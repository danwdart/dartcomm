<?php
namespace DartComm\Model;

class Identity extends ModelAbstract
{
	public function __construct($strUsername, $strPassword)
	{
		$this->Username = $strUsername;
		$this->Password = $strPassword;
	}
}