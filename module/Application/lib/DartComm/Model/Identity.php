<?php
namespace DartComm\Model;

class Identity extends ModelAbstract
{
	public function __construct($strServer, $strUsername, $strPassword, $intPort, $bSSL, $bRequireVerification)
	{
		$this->Server = $strServer;
		$this->Username = $strUsername;
		$this->Password = $strPassword;
		$this->Port = $intPort;
		$this->bSSL = $bSSL;
		$this->bRequireVerification = $bRequireVerification;
	}
}