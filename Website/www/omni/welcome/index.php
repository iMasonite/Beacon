<?php

require(dirname(__FILE__, 4) . '/framework/loader.php');

BeaconCommon::StartSession();

BeaconTemplate::SetTitle('Thanks for purchasing!');
BeaconTemplate::StartScript(); ?>
<script>
	
var number_of_checks = 0;

document.addEventListener('DOMContentLoaded', function() {
	setTimeout(function() {
		check_purchase_status(<?php echo (isset($_SESSION['client_reference_id']) ? json_encode($_SESSION['client_reference_id']) : 'null'); ?>);
	}, 1000);
});

function check_purchase_status(client_reference_id) {
	if (client_reference_id == null) {
		document.getElementById('checking_container').style.display = 'none';
		document.getElementById('purchase_unknown').style.display = 'block';
		document.getElementById('signin_instructions').style.display = 'block';
		return;
	}
	
	number_of_checks++;
	request.start('GET', 'status.php?client_reference_id=' + encodeURIComponent(client_reference_id), function(obj) {
		document.getElementById('checking_container').style.display = 'none';
		document.getElementById('checking_container').style.display = 'none';
		document.getElementById('purchase_delayed').style.display = 'block';
		
		var email = obj.email;
		var user_id = obj.user_id;
		
		if (user_id == null) {
			document.getElementById('confirmed_text').innerText = 'You will need to create an account with the email address "' + email + '" to activate Omni in Beacon.';
			document.getElementById('activate_button').innerText = 'Create Account in Beacon';
			document.getElementById('activate_button').href = 'beacon://activate_account?email=' + encodeURIComponent(email) + '&new_account=true';
		} else {
			document.getElementById('confirmed_text').innerText = 'Your account "' + email + '" is ready to use Omni. Simply relaunch Beacon or click the "Activate Omni" button below to have Beacon refresh your account status.';
			document.getElementById('activate_button').href = 'beacon://activate_account?email=' + encodeURIComponent(email);
		}
	}, function(http_status, raw_body) {
		setTimeout(function() {
			if (number_of_checks == 1) {
				document.getElementById('checking_subtext').innerText = "\nWaiting for purchase details from Stripe…";
			} else if (number_of_checks == 10) {
				document.getElementById('purchase_delayed').style.display = 'block';
				document.getElementById('signin_instructions').style.display = 'block';
			}
			check_purchase_status(client_reference_id);
		}, 3000);
	});
}

</script>
<?php
BeaconTemplate::FinishScript();

BeaconTemplate::StartStyles(); ?>
<style type="text/css">

#checking_container {
	background-color: rgba(0, 0, 0, 0.02);
	border: 1px solid rgba(0, 0, 0, 0.1);
	padding: 12px;
	border-radius: 6px;
	text-align: center;
}

#checking_spinner {
	vertical-align: middle;
	margin-right: 12px;
}

#checking_text {
	line-height: 1.5em;
	font-weight: bold;
}

#checking_subtext {
	font-size: smaller;
	color: rgba(0, 0, 0, 0.8);
}

#purchase_confirmed {
	display: none;
}

#purchase_unknown {
	display: none;
}

#purchase_delayed {
	margin-top: 30px;
	display: none;
}

#signin_instructions {
	display: none;
	margin-top: 30px;
}

.welcome_content {
	width: 100%;
	margin-left: auto;
	margin-right: auto;
	max-width: 500px;
	box-sizing: border-box;
}

.push {
	clear: both;
	overflow: hidden;
	height: 0px;
}

.signin_step+.signin_step {
	margin-top: 20px;
	border-top: 1px solid rgba(0, 0, 0, 0.2);
	padding-top: 20px;
}

#img_signin_menu {
	background-image: url(menu.png);
	width: 150px;
	height: 118px;
	background-size: 100%;
	border: 1px solid #afafaf;
	float: left;
}

.signin_text {
	padding-left: 170px;
}

#img_signin_link {
	background-image: url(signin.png);
	width: 150px;
	height: 59px;
	background-size: 100%;
	border: 1px solid #afafaf;
	float: left;
}

#img_signin_enable {
	background-image: url(enable_cloud.png);
	width: 150px;
	height: 59px;
	background-size: 100%;
	border: 1px solid #afafaf;
	float: left;
	clear: left;
	margin-top: 6px;
}

#img_signin_options {
	background-image: url(options.png);
	width: 150px;
	height: 59px;
	background-size: 100%;
	border: 1px solid #afafaf;
	float: left;
}

#img_signin_fields {
	background-image: url(fields.png);
	width: 150px;
	height: 59px;
	background-size: 100%;
	border: 1px solid #afafaf;
	float: left;
	clear: left;
	margin-top: 6px;
}

</style>
<?php
BeaconTemplate::FinishStyles();

?><h1 class="text-center">Thanks for purchasing Beacon Omni!</h1>
<div id="checking_container" class="welcome_content">
	<p><img src="/assets/images/spinner.svg" width="64" height="64" id="checking_spinner"></p>
	<p><span id="checking_text">Checking purchase status&hellip;</span><span id="checking_subtext"></span></p>
</div>
<div id="purchase_confirmed" class="welcome_content">
	<p id="confirmed_text"></p>
	<p class="text-center"><a href="" id="activate_button" class="button">Activate Omni</a>
</div>
<div id="purchase_unknown" class="welcome_content">
	<p>Your purchase status cannot be retrieved. Maybe your browser is blocking cookies. Maybe you're visiting this page from a different browser than the one you purchased with. Or maybe something has simply gone wrong.</p>
	<p>Don't worry though, your purchase will still be completed normally. After you receive your receipt via email, sign into Beacon using the same email address that was used for the purchase, and Beacon Omni should be activated. If not, it means Stripe hasn't yet sent over purchase details, so wait a few minutes then relaunch Beacon.</p>
</div>
<div id="purchase_delayed" class="welcome_content">
	<p>This is unusual, but Stripe has not sent over purchase details yet. Unfortunately, the only option is to wait.</p>
	<p>In the meantime, follow the instructions below to sign into Beacon. Once Omni has been activated for your account, you'll only need to restart Beacon to use it.</p>
	<p>You can safely leave this page at any time, your purchase will still be completed.</p>
</div>
<div id="signin_instructions" class="welcome_content">
	<h3>How to sign into Beacon</h3>
	<div class="signin_step">
		<div id="img_signin_menu">&nbsp;</div>
		<div class="signin_text">
			<h4>Open the menu</h4>
			<p>Use the icon with the 3 lines, shown circled in red here.</p>
		</div>
		<div class="push">&nbsp;</div>
	</div>
	<div class="signin_step">
		<div id="img_signin_link">&nbsp;</div>
		<div id="img_signin_enable">&nbsp;</div>
		<div class="signin_text">
			<h4>Click the &quot;Sign In&quot; link</h4>
			<p>If you see &quot;Enable Cloud &amp; Community&quot; instead, click that one.</p>
			<p>If you see your email address instead, you're already signed in! Relaunch Beacon to activate Omni. Or you can click &quot;Sign Out&quot; if you see a different email address.</p>
		</div>
		<div class="push">&nbsp;</div>
	</div>
	<div class="signin_step">
		<div id="img_signin_options">&nbsp;</div>
		<div id="img_signin_fields">&nbsp;</div>
		<div class="signin_text">
			<h4>Login or create your account</h4>
			<p>Click &quot;Login with Email&quot; if given the option, which will display the login form. Otherwise Beacon will bring you directly to the form.</p>
			<p>Enter your email address and password, or click &quot;Create or Recover Beacon Account&quot; to setup a password. Follow the steps in Beacon.</p>
		</div>
		<div class="push">&nbsp;</div>
	</div>
</div>