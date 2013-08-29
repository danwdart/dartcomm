<?php
namespace DartComm\Model;

use Ddeboer\Imap\Message as ImapMessage;

class Message
{
	private $_imapMessage;

	public function __construct(ImapMessage $imapMessage)
	{
		$this->_imapMessage = $imapMessage;
	}

	public function getMessageId()
	{
		return $this->_imapMessage->getId();
	}

	public function getMessageNumber()
	{
		return $this->_imapMessage->getNumber();
	}

	public function getSender()
	{
		return new Contact($this->_imapMessage->getFrom());
	}

	public function getRecipient()
	{
		return new Contact($this->_imapMessage->getTo());
	}

	public function getDate()
	{
		return $this->_imapMessage->getDate();
	}

	public function getSize()
	{
		return $this->_imapMessage->getSize();
	}

	public function bIsAnswered()
	{
		return $this->_imapMessage->isAnswered();
	}

	public function bIsDeleted()
	{
		return $this->_imapMessage->isDeleted();
	}

	public function bIsDraft()
	{
		return $this->_imapMessage->isDraft();
	}

	public function getSubject()
	{
		return $this->_imapMessage->getSubject();
	}

	public function getHeaders()
	{
		$arrHeaders = [];
		foreach($this->_imapMessage->getHeaders() as $strKey => $header) {
			$arrHeaders[$strKey] = $header;
		}
		return $arrHeaders;
	}

	public function getBodyHtml()
	{
		return $this->_imapMessage->getBodyHtml();
	}

	public function getBodyText()
	{
		return $this->_imapMessage->getBodyText();
	}

	public function getAttachments()
	{
		foreach($this->_imapMessage->getAttachments() as $attachment) {
			yield new File($attachment);
		}
	}

	public function hasAttachments()
	{
		return $this->_imapMessage->hasAttachments();
	}

	public function setHeader($strKey, $strValue)
	{

	}
}