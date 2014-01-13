<?php
namespace DartComm\Exception;

use \Exception;

class ConnectionFailed extends Exception
{
	const MESSAGE = 'Failed to connect to (%s). Please check details.';

	public function __construct($strConn)
	{
		parent::__construct(sprintf(self::MESSAGE, $strConn));
	}
}