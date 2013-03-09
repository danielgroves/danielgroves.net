<?php
ini_set('error_reporting', E_ALL);

$name 		= false;
$subject 	= false;
$email 		= false;
$message 	= false;

if (isset($_POST['name']) && $_POST['name'] != '')
	$name = true;

if (isset($_POST['subject']) && $_POST['subject'] != '')
	$subject = true;

if (isset($_POST['email']) && $_POST['email'] != '')
	$email = true;

if (isset($_POST['message']) && $_POST['message'] != '')
	$message = true;

if ( !$name || !$subject || !$email || !$message )
	die('You did not fill out all form fields. Please go back and try again.');

if ( $name && $subject && $email && $message ) {
	
	$to      = 'hello@danielgroves.net';
	$headers = 'From: ' . $_POST['name'] . '<' . $_POST['email'] . ">\r\n" .
	    'Reply-To: ' . $_POST['email'] . "\r\n" .
	    'X-Mailer: PHP/' . phpversion();

	if (mail($to, $_POST['subject'], $_POST['message'], $headers)) {
		if (!isset($_GET['js']))
			header('Location: /contact/sent.html');
		else
			die('Email sent.');
	} else 
		die('Sorry, and error occured. Please try again later. ');
	
}

?>