<?php
namespace DartComm\Comm\Protocol;

use DartComm\Model\Identity;
use DartComm\Model\Server;
use DartComm\Exception\ConnectionFailed;
use DartComm\Model\Mailbox;
use Ddeboer\Imap\Server as ImapServer;

class Imap implements ProtocolInterface
{
	private $_server;
	private $_identity;
	private $_strFlags;
	private $_imap;
	private $_imapMailbox;

	public function __construct(Server $server, Identity $identity)
	{
		$this->_identity = $identity;
		$this->_server = $server;
		$this->_strFlags = (($server->bSSL)?'/ssl':'').
			(($server->bRequireVerification)?'':'/novalidate-cert');

		$this->_imap = new ImapServer(
			$server->Host,
			$server->Port,
			$this->_strFlags
		);

		try {
			$this->_connection = $this->_imap->authenticate(
				$this->_identity->Username,
				$this->_identity->Password
			);
		} catch (\InvalidArgumentException $e) {
			throw new ConnectionFailed($this->_strConnectionString);
		}
	}

	public function getMailbox($strName)
	{
		return new Mailbox($this->_connection->getMailbox($strName));
	}

	public function getMailboxes()
	{
		foreach($this->_connection->getMailboxes() as $imapMailbox) {
			yield new Mailbox($imapMailbox);
		}
	}

	public function getMailboxNames()
	{
		return $this->_connection->getMailboxNames();
	}
}