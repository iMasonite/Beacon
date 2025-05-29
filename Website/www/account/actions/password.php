<?php

header('Content-Type: application/json');
header('Cache-Control: no-cache, no-store, must-revalidate');
header('Pragma: no-cache');
header('Expires: 0');
http_response_code(500);

require(dirname(__FILE__, 4) . '/framework/loader.php');

use BeaconAPI\v4\{Response, Session, User, UserGenerator};

$activeSession = BeaconCommon::GetSession();
if (is_null($activeSession)) {
	Response::NewJsonError('Unauthorized', null, 401)->Flush();
	exit;
}

if (empty($_POST['current_password']) || empty($_POST['password'])) {
	Response::NewJsonError('Missing parameters', null, 400)->Flush();
	exit;
}

$currentPassword = $_POST['current_password'];
$password = $_POST['password'];
$allowVulnerable = filter_var($_POST['allow_vulnerable'] ?? false, FILTER_VALIDATE_BOOLEAN);
$regenerateKey = filter_var($_POST['regenerate_key'] ?? false, FILTER_VALIDATE_BOOLEAN);
$terminateSessions = filter_var($_POST['terminate_sessions'] ?? false, FILTER_VALIDATE_BOOLEAN);

$database = BeaconCommon::Database();

if (!User::ValidatePassword($password)) {
	Response::NewJsonError('Password must be at least 8 characters and you should avoid repeating characters.', null, 437)->Flush();
	exit;
}

$user = $activeSession->User();
if ($user->Is2FAProtected()) {
	$authCode = $_POST['auth_code'] ?? '';
	if ($user->Verify2FACode($authCode, true, User::VerifyWithAuthenticators) === false) {
		Response::NewJsonError(message: 'The provided code is not correct for any of your authenticators.', code: 'invalidAuthCode', httpStatus: 403)->Flush();
		exit;
	}
}

if ($allowVulnerable == false) {
	$hash = strtolower(sha1($password));
	$prefix = substr($hash, 0, 5);
	$suffix = substr($hash, 5);
	$url = 'https://api.pwnedpasswords.com/range/' . $prefix;
	$hashes = explode("\n", file_get_contents($url));
	foreach ($hashes as $hash) {
		$count = intval(substr($hash, 36));
		$hash = strtolower(substr($hash, 0, 35));
		if ($hash == $suffix && $count > 0) {
			// vulnerable
			Response::NewJsonError('Password is listed as vulnerable according to haveibeenpwned.com.', null, 438)->Flush();
			exit;
		}
	}
}

try {
	UserGenerator::ChangePassword($user, $currentPassword, $password, $activeSession, $regenerateKey);
	Response::NewJson([
		'session_id' => $activeSession->SessionId()
	], 200)->Flush();
	exit;
} catch (Exception $err) {
	Response::NewJsonError($err->getMessage(), null, 400)->Flush();
	exit;
}

?>
