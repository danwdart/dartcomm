<?php
namespace DartComm\Comm\Protocol;

use DartComm\Model\Contact;
use DartComm\Model\Identity;
use DartComm\Model\Message;
use DartComm\Exception\ConnectionFailed;

class Imap implements ProtocolInterface
{
	private $_identity;
	private $_strConnectionString;
	private $_imap;
	private $_imapMailbox;

	public function __construct(Identity $identity)
	{
		$this->_identity = $identity;
		$this->_strConnectionString = '{'.
			$identity->Server.
			':'.
			$identity->Port.
			(($identity->bSSL)?'/ssl':'').
			(($identity->bRequireVerification)?'':'/novalidate-cert').
			'}';

		$this->_imap = \imap_open(
			$this->_strConnectionString,
			$identity->Username,
			$identity->Password
		);

		if (!$this->_imap) {
			throw new ConnectionFailed($this->_strConnectionString);
		}
	}

	public function __destruct()
	{
		\imap_close($this->_imap);
		\imap_close($this->_imapMailbox);
	}

	public function deleteOne($mixedId)
	{

	}

	public function getAll($strMailbox, $intSkip, $intCount)
	{
		$this->_imapMailbox = \imap_open(
			$strMailbox,
			$this->_identity->Username,
			$this->_identity->Password
		);
		for ($i = $intSkip+1; $i <= $intSkip + $intCount + 1; $i++) {
			$objHeader = @\imap_headerinfo($this->_imapMailbox, $i);
			if (false !== $objHeader)
				yield $objHeader;
		}
	}

	public function getMailboxes()
	{
		return \imap_listmailbox($this->_imap, $this->_strConnectionString, '*');
	}

	public function getMailboxNames()
	{
		$mbs = $this->getMailboxes();
		foreach($mbs as $strName) {
			yield str_replace($this->_strConnectionString, '', $strName);
		}
	}

	public function getStructure($mixedId)
	{
		return \imap_fetchstructure($this->_imapMailbox, $mixedId);

	}

	public function getPart($mixedId, $intPart)
	{
		return \imap_fetchbody($this->_imapMailbox, $mixedId, $intPart);
	}

	public function send(Contact $contact, Message $message)
	{
		
	}
}