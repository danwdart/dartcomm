<?php
namespace DartComm\Comm\Protocol;

use DartComm\Model\Identity;
use DartComm\Model\Contact;
use DartComm\Model\Message;

interface ProtocolInterface
{
	public function __construct(Identity $identity);
	public function deleteOne($mixedId);
	//public function getAll($strMailbox);
	//public function getOne($mixedId);
	public function send(Contact $contact, Message $message);
}