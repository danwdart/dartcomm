<?php
namespace DartComm\Model;

use Ddeboer\Imap\Message\EmailAddress;

class Contact extends Abstract
{
	private $_emailaddress;

	public function __construct(EmailAddress $address)
	{
		$this->_emailaddress = $address;
	}

	public function getDisplayName()
	{
		return $this->_emailaddress->getName();
	}

	public function getEmailAddress()
	{
		return $this->_emailaddress->getAddress();
	}
}