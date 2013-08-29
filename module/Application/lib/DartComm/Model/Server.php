<?php
namespace DartComm\Model;

use DartComm\Comm\Protocol\Imap;

class Server extends ModelAbstract
{
	public function __construct($strHost, $intPort, $bSSL, $bRequireVerification)
	{
		$this->Host = $strHost;
		$this->Port = $intPort;
		$this->bSSL = $bSSL;
		$this->bRequireVerification = $bRequireVerification;
	}	


	public function authenticate(Identity $identity)
	{
		return new Imap($this, $identity);
	}
}