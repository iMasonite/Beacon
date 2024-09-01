<?php

BeaconAPI::Authorize();

function handleRequest(array $context): Response {
	$user_id = BeaconAPI::UserID();

	try {
		$service = Sentinel\Service::Create($user_id, BeaconAPI::JSONPayload());
		BeaconAPI::ReplySuccess($service);
	} catch (Exception $err) {
		BeaconAPI::ReplyError($err->getMessage(), null, 400);
	}
}

?>
