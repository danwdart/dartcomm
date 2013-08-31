<?php
namespace DartComm\Exception;

use \Exception;

class AuthenticationFailed extends Exception
{
	const MESSAGE = 'Failed to authenticate. Please check details.';

	public function __construct()
	{
		parent::__construct(sprintf(self::MESSAGE));
	}
}