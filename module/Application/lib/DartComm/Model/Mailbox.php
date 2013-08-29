<?php
namespace DartComm\Model;

use Ddeboer\Imap\Mailbox as ImapMailbox;
use DartComm\Iterator\ObjectIterator;

class Mailbox implements \Countable
{
	private $_imapMailbox;

	public function __construct(ImapMailbox $imapMailbox)
	{
		$this->_imapMailbox = $imapMailbox;
	}

	public function count()
	{
		return $this->_imapMailbox->count();
	}

	public function getName()
	{
		return $this->_imapMailbox->getName();
	}

	public function getAll()
	{
		return new ObjectIterator(
			$this->_imapMailbox->getMessages(),
			'\DartComm\Model\Message'
		);
	}

	public function getMessageById($id)
	{
		return new Message($this->_imapMailbox->getMessage($id));
	}
}