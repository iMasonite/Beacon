<?php

require(dirname(__FILE__, 3) . '/framework/loader.php');

use BeaconAPI\v4\Session;

if (isset($_REQUEST['code'])) {
	$code = substr($_REQUEST['code'], 0, 9);
} else {
	$code = '';
}

BeaconCommon::StartSession();
$session = BeaconCommon::GetSession();
$is_logged_in = is_null($session) === false;
$user = $is_logged_in ? $session->User() : null;

header('Cache-Control: no-cache');

$database = BeaconCommon::Database();

BeaconTemplate::AddStylesheet(BeaconCommon::AssetURI('account.css'));

$process_step = 'start';
if (isset($_REQUEST['process'])) {
	$process_step = strtolower($_REQUEST['process']);
}

?><div id="redeem_form" class="reduced-width">
	<h1>Beacon Gift Codes</h1>
	<?php

	switch ($process_step) {
	case 'redeem-final':
	case 'redeem-confirm':
		RedeemCode($code, $process_step === 'redeem-final');
		break;
	default:
		ShowForm($code);
		break;
	}

	?>
</div><?php

function RedeemCode(string $code, bool $confirmed): void {
	global $user;

	if (is_null($user) || is_null($user->EmailId())) {
		$return = BeaconCommon::AbsoluteURL('/account/redeem/' . urlencode($code) . '?process=redeem-confirm');
		BeaconCommon::Redirect('/account/login/?return=' . urlencode($return));
		return;
	}

	$database = BeaconCommon::Database();
	$results = $database->Query('SELECT redemption_date FROM public.gift_codes WHERE code = $1;', $code);
	if ($results->RecordCount() === 0 || is_null($results->Field('redemption_date')) === false) {
		LogRedeemAttempt($code, $user->UserID(), false);
		ShowForm($code, 'The gift code does not exist or was already redeemed.');
		return;
	}

	if ($user->IsBanned()) {
		LogRedeemAttempt($code, $user->UserID(), false);
		BeaconCommon::PostSlackMessage('Banned account ' . $user->UserID() . ' tried to redeem gift code ' . $code . '.');
		BeaconCommon::Redirect('https://www.youtube.com/watch?v=sKbP-M8vVtw', false);
		return;
	}

	$licenses = $user->Licenses();
	$licenseMap = [];
	foreach ($licenses as $license) {
		$licenseMap[$license->ProductId()] = $license;
	}

	$results = $database->Query('SELECT products.product_id, products.product_name, gift_code_products.quantity FROM public.gift_code_products INNER JOIN public.products ON (gift_code_products.product_id = products.product_id) WHERE gift_code_products.code = $1 ORDER BY products.product_name;', $code);
	if ($results->RecordCount() === 1 && array_key_exists($results->Field('product_id'), $licenseMap) && $licenseMap[$results->Field('product_id')]->Expires() === false) {
		echo '<p>You already own ' . htmlentities($results->Field('product_name')) . '. You cannot redeem this gift code.</p>';
		return;
	}

	if ($confirmed) {
		// Redeem the gift code
		$gift_products = [];
		$regular_products = [];
		$bundles = [];

		while (!$results->EOF()) {
			$productId = $results->Field('product_id');
			$quantity = $results->Field('quantity');

			if (array_key_exists($productId, $licenseMap) && $licenseMap[$productId]->Expires() === false) {
				$gift_products[$productId] = ($gift_products[$productId] ?? 0) + $quantity;
			} else {
				$regular_products[$productId] = ($regular_products[$productId] ?? 0) + $quantity;
			}

			$results->MoveNext();
		}

		if (count($regular_products) > 0) {
			$bundles[] = BeaconShop::CreateBundle($regular_products, false);
		}
		if (count($gift_products) > 0) {
			$bundles[] = BeaconShop::CreateBundle($gift_products, true);
		}

		$database->BeginTransaction();
		$purchaseId = BeaconShop::GrantProducts($user->EmailId(), $bundles, "Redeemed gift code {$code}", true);
		$database->Query('UPDATE gift_codes SET redemption_purchase_id = $2, redemption_date = CURRENT_TIMESTAMP WHERE code = $1;', $code, $purchaseId);
		LogRedeemAttempt($code, $user->UserID(), true);
		$database->Commit();

		echo '<p class="text-center"><span class="text-blue">Gift code redeemed!</span><br><a href="/account/#omni">Activation instructions</a> are available if you need them.</p>';
	} else {
		// Show confirmation
		echo '<form action="/account/redeem" method="post"><input type="hidden" name="process" value="redeem-final"><input type="hidden" name="code" value="' . htmlentities($code) . '">';
		echo '<p>The following products will be added to account ' . htmlentities($user->Username()) . '<span class="user-suffix">#' . htmlentities($user->Suffix()) . '</span>.</p>';

		echo '<ul>';
		while (!$results->EOF()) {
			$productId = $results->Field('product_id');
			$productName = $results->Field('product_name');
			$quantity = $results->Field('quantity');

			echo '<li>' . ($quantity > 1 ? $quantity . ' x ' : '') . htmlentities($productName);

			if (array_key_exists($productId, $licenseMap) && $licenseMap[$productId]->Expires() === false) {
				echo '<br><span class="text-blue">You already own ' . htmlentities($productName) . '. You will be given a gift code for it instead. Share it with somebody.</span>';
			}

			echo '</li>';

			$results->MoveNext();
		}
		echo '</ul>';

		echo '<div class="double-group"><div>&nbsp;</div><div><div class="button-group"><div><a href="/account/redeem" class="button">Cancel</a></div><div><input type="submit" value="Redeem"></div></div></div>';
		echo '</form>';
	}
}

function ShowForm(string $code, ?string $error = null): void {
	global $user;

	echo '<form action="/account/redeem" method="post"><input type="hidden" name="process" value="redeem-confirm"><p>Got a Beacon gift code? Redeem it here!</p>';

	if (empty($error) === false) {
		echo '<p class="text-center text-red">' . htmlentities($error) . '</p>';
	}

	echo '<div class="floating-label"><input type="text" class="text-field" name="code" placeholder="Code" minlength="9" maxlength="9" value="' . htmlentities($code) . '"><label>Gift Code</label></div>';

	if (is_null($user)) {
		echo '<p class="text-right bold">You will be be asked to log in or create an account to redeem this code.</p>';
		echo '<p class="text-right"><input type="submit" value="Sign In and Redeem"></p>';
	} else {
		echo '<p class="text-right"><input type="submit" value="Redeem"></p>';
	}
}

function LogRedeemAttempt(string $code, string $user_id, bool $success): void {
	$database = BeaconCommon::Database();
	$database->BeginTransaction();
	$database->Query('INSERT INTO gift_code_log (code, user_id, source_ip, success) VALUES ($1, $2, $3, $4);', $code, $user_id, BeaconCommon::RemoteAddr(true), $success);
	$database->Commit();
}

?>
