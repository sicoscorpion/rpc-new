<?php

require_once 'app/vendor/mail.php';

class Mail
{
	/** @var mixed variable to collect errors */
	private $error;


	public function sendMail($user_email, $from_email, $from_name, $subject, $body)
	{
		return mail_f($user_email, $subject, $body);

	}

	public function getError()
	{
		return $this->error;
	}
}
