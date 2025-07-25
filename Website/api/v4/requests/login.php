<?php

use BeaconAPI\v4\{Application, ApplicationAuthFlow, Core, DeviceAuthFlow, Response, Session, User};

function setupAuthParameters(string &$authScheme, array &$requiredScopes, bool $editable): void {
	$requiredScopes = [];
	$authScheme = Core::kAuthSchemeNone;
}

function handleRequest(array $context): Response {
	switch ($context['routeKey']) {
	case 'GET /login':
		// Start an authorization flow
		$clientId = $_GET['client_id'] ?? '';
		$scopes = empty($_GET['scope']) ? [] : explode(' ', $_GET['scope']);
		$redirectUri = $_GET['redirect_uri'] ?? '';
		$state = $_GET['state'] ?? '';
		$responseType = $_GET['response_type'] ?? '';
		$codeVerifierHash = $_GET['code_challenge'] ?? '';
		$codeVerifierMethod = $_GET['code_challenge_method'] ?? '';
		$publicKey = $_GET['public_key'] ?? null;
		$userId = $_GET['user_id'] ?? '';
		$signature = $_GET['signature'] ?? '';
		$expiration = $_GET['expiration'] ?? '';
		$deviceId = $_GET['device_id'] ?? $_GET['deviceId'] ?? '';
		$application = null;

		if (empty($clientId) || empty($scopes)) {
			return Response::NewJsonError('Missing parameters', null, 400);
		}

		$response = HandlePublicKeyAuth($clientId, $application, $publicKey, $scopes, $userId, $signature, $expiration);
		if (is_null($response) === false) {
			return $response;
		}

		if (empty($redirectUri) || empty($state) || empty($responseType) || empty($codeVerifierHash) || empty($codeVerifierMethod)) {
			return Response::NewJsonError('Missing parameters', null, 400);
		}

		if ($responseType !== 'code') {
			return Response::NewJsonError('Response type should be code', null, 400);
		}
		if ($codeVerifierMethod !== 'S256') {
			return Response::NewJsonError('This API does not support the supplied code challenge method', null, 400);
		}
		if (strlen($codeVerifierHash) !== 43) {
			return Response::NewJsonError('The code challenge should be exactly 43 characters when Base64URL encoded', null, 400);
		}

		if (is_null($application)) {
			$application = Application::Fetch($clientId);
			if (is_null($application)) {
				return Response::NewJsonError('Invalid client id', null, 400);
			}
		}

		$flow = null;
		try {
			if (is_null($publicKey) === false) {
				$publicKey = BeaconEncryption::PublicKeyToPEM($publicKey);
			}

			$flow = ApplicationAuthFlow::Create($application, $scopes, $redirectUri, $state, $codeVerifierHash, $codeVerifierMethod, $publicKey);
		} catch (Exception $err) {
			return Response::NewJSONError($err->getMessage(), null, 400);
		}
		if (is_null($flow)) {
			return Response::NewJsonError('Invalid scope or redirect_uri', null, 400);
		}

		$query = [
			'flow_id' => $flow->FlowId(),
		];
		if (empty($deviceId) === false) {
			$query['device_id'] = $deviceId;
		}
		$loginUrl = BeaconCommon::AbsoluteUrl('/account/login?' . http_build_query($query));
		if (isset($_GET['no_redirect']) && filter_var($_GET['no_redirect'], FILTER_VALIDATE_BOOLEAN) === true) {
			return Response::NewJson([
				'login_url' => $loginUrl
			], 200);
		} else {
			return Response::NewRedirect($loginUrl);
		}
	case 'POST /login':
		// Redeem an authorization or device flow
		if (Core::IsJsonContentType()) {
			$obj = Core::BodyAsJson();
		} else {
			$obj = $_POST;
		}
		$grantType = $obj['grant_type'] ?? null;
		$clientId = $obj['client_id'] ?? null;
		$clientSecret = $obj['client_secret'] ?? null;

		if (is_null($grantType)) {
			return Response::NewJsonError('Invalid grant type', ['code' => 'INVALID_GRANT'], 400);
		}

		switch ($grantType) {
		case 'authorization_code':
			$code = $obj['code'] ?? '';
			$redirectUri = $obj['redirect_uri'] ?? '';
			$codeVerifier = $obj['code_verifier'] ?? '';

			if (empty($grantType) || empty($code) || empty($clientId) || empty($redirectUri)) {
				return Response::NewJsonError('Missing parameters', ['code' => 'INVALID_GRANT'], 400);
			}

			try {
				$session = ApplicationAuthFlow::Redeem($clientId, $clientSecret, $redirectUri, $code, $codeVerifier);
				if (is_null($session)) {
					return Response::NewJsonError('Invalid code', ['code' => 'INVALID_CODE'], 400);
				}
				Core::SetSession($session);
				return Response::NewJson($session->OAuthResponse(), 201);
			} catch (Exception $err) {
				return Response::NewJsonError($err->getMessage() ?: 'Unhandled exception redeeming auth flow', ['code' => 'INVALID_CODE'], 400);
			}
		case 'device_code':
		case 'urn:ietf:params:oauth:grant-type:device_code':
			try {
				$deviceCode = $obj['device_code'] ?? '';
				$codeVerifier = $obj['code_verifier'] ?? '';

				$flow = DeviceAuthFlow::Fetch($deviceCode);
				if (is_null($flow)) {
					return Response::NewJsonError(message: 'Authorization flow not found.', code: 'flowNotFound', httpStatus: 404);
				}

				if ($flow->ApplicationId() !== $clientId) {
					return Response::NewJsonError(message: 'Incorrect client id.', code: 'invalidClientId', httpStatus: 400);
				}

				if ($flow->IsCompleted() === false) {
					return Response::NewJson([
						'error' => 'authorization_pending',
					], 400);
				}

				$session = $flow->Redeem($codeVerifier, $clientSecret);
				Core::SetSession($session);
				return Response::NewJson($session->OAuthResponse(), 201);
			} catch (Exception $err) {
				if ($err instanceof APIException) {
					return Response::NewJsonError(message: $err->getMessage(), code: $err->getBeaconErrorCode(), httpStatus: $err->getHttpStatus());
				} else {
					return Response::NewJSONError(message: $err->getMessage(), code: 'exception', httpStatus: 400);
				}
			}
		case 'refresh_token':
			$refreshToken = $obj['refresh_token'] ?? null;
			$scopes = explode(' ', $obj['scope']) ?? null;
			$session = Session::Fetch($refreshToken);
			if (is_null($session) || $session->IsRefreshTokenExpired()) {
				return Response::NewJsonError('Unauthorized', ['code' => 'EXPIRED'], 403);
			}
			$app = $session->Application();
			if (is_null($scopes) === false) {
				if ($session->HasScopes($scopes) === false) {
					return Response::NewJsonError('Invalid scopes', ['code' => 'INVALID_SCOPES'], 400);
				}
			} else {
				$scopes = $session->Scopes();
			}
			if ($app->IsConfidential() && (is_null($clientId) || is_null($clientSecret) || $app->ApplicationId() !== $clientId || $app->Secret() !== $clientSecret)) {
				return Response::NewJsonError('Invalid client', ['code' => 'INVALID_CLIENT'], 400);
			}
			$newSession = $session->Renew(true);
			Core::SetSession($newSession);
			return Response::NewJson($newSession->OAuthResponse(), 201);
		default:
			return Response::NewJsonError('Invalid grant type', ['code' => 'INVALID_GRANT'], 400);
		}
	case 'POST /device':
		// Start a device flow
		if (Core::IsJsonContentType()) {
			$obj = Core::BodyAsJson();
		} else {
			$obj = $_POST;
		}

		$clientId = $obj['client_id'] ?? '';
		$clientSecret = $obj['client_secret'] ?? null;
		$scopes = empty($obj['scope']) ? [] : explode(' ', $obj['scope']);
		$publicKey = $obj['public_key'] ?? null;
		$codeVerifierHash = $obj['code_challenge'] ?? '';
		$codeVerifierMethod = $obj['code_challenge_method'] ?? '';

		if (empty($clientId) || empty($scopes)) {
			return Response::NewJsonError(message: 'Missing parameters', code: 'missingParameters', httpStatus: 400);
		}

		if ($codeVerifierMethod !== 'S256') {
			return Response::NewJsonError('This API does not support the supplied code challenge method', null, 400);
		}
		if (strlen($codeVerifierHash) !== 43) {
			return Response::NewJsonError('The code challenge should be exactly 43 characters when Base64URL encoded', null, 400);
		}

		$application = Application::Fetch($clientId);
		if (is_null($application)) {
			return Response::NewJsonError(message: 'Invalid client id', code: 'invalidClientId', httpStatus: 400);
		}
		if ($application->IsConfidential() && $application->CheckSecret($clientSecret) === false) {
			return Response::NewJsonError(message: 'Incorrect client secret', code: 'invalidClientSecret', httpStatus: 403);
		}

		$deviceCode = DeviceAuthFlow::CreateDeviceCode();
		$flow = null;
		try {
			if (is_null($publicKey) === false) {
				$publicKey = BeaconEncryption::PublicKeyToPEM($publicKey);
			}

			$flow = DeviceAuthFlow::Create($deviceCode, $application, $scopes, $codeVerifierHash, $codeVerifierMethod, $publicKey);
		} catch (Exception $err) {
			if ($err instanceof APIException) {
				return Response::NewJsonError(message: $err->getMessage(), code: $err->getBeaconErrorCode(), httpStatus: $err->getHttpStatus());
			} else {
				return Response::NewJSONError(message: $err->getMessage(), code: 'exception', httpStatus: 400);
			}
		}
		if (is_null($flow)) {
			return Response::NewJsonError(message: 'Invalid scope', code: 'invalidScope', httpStatus: 400);
		}

		return Response::NewJson([
			'device_code' => $flow->FlowId(),
			'user_code' => $deviceCode,
			'verification_uri' => BeaconCommon::AbsoluteUrl('/device'),
			'verification_uri_complete' => BeaconCommon::AbsoluteUrl('/device?code=' . urlencode($deviceCode)),
			'interval' => 5,
			'expires_in' => $flow->ExpiresIn(),
		], 201);
	default:
		return Response::NewJsonError('Unknown route', null, 500);
	}
}

function HandlePublicKeyAuth(string $clientId, &$application, &$publicKey, array $scopes, string $userId, string $signature, string $expiration): ?Response {
	if (empty($userId) || empty($publicKey) || empty($signature) || empty($expiration) || empty($scopes) || in_array(Application::kScopeAuthPublicKey, $scopes) === false) {
		return null;
	}

	$application = Application::Fetch($clientId);
	if (is_null($application)) {
		return Response::NewJsonError('Invalid client id', null, 400);;
	}
	if ($application->HasScope(Application::kScopeAuthPublicKey) === false) {
		return null;
	}

	$user = User::Fetch($userId);
	if (is_null($user)) {
		$publicKey = BeaconEncryption::PublicKeyToPEM($publicKey);
	} else {
		if ($user->IsAnonymous() === false) {
			return null;
		}
		$publicKey = $user->PublicKey();
	}
	$stringToSign = $userId . ';' . $expiration;
	$expiration = filter_var($expiration, FILTER_VALIDATE_INT);
	if ($expiration < time() || $expiration > time() + 120) {
		return Response::NewJsonError('Signature has expired or is too far in the future.', null, 400);
	}
	$verified = BeaconEncryption::RSAVerify($publicKey, $stringToSign, BeaconCommon::Base64UrlDecode($signature));
	if (!$verified) {
		return Response::NewJsonError('Incorrect signature', null, 400);
	}

	$database = BeaconCommon::Database();
	$database->BeginTransaction();
	try {
		if (is_null($user)) {
			$user = User::Create([
				'userId' => $userId,
				'publicKey' => $publicKey,
				'cloudKey' => bin2hex(BeaconEncryption::RSAEncrypt($publicKey, User::GenerateCloudKey()))
			]);
		}

		$session = Session::Create($user, $application, $scopes);
		$database->Commit();
		Core::SetSession($session);
		return Response::NewJson($session->OAuthResponse(), 201);
	} catch (Exception $err) {
		// Do nothing
		$database->Rollback();
		return Response::NewJsonError($err->getMessage(), null, 400);
	}
}

?>
