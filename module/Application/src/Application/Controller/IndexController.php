<?php
namespace Application\Controller;

use Zend\Mvc\Controller\AbstractActionController as Action;
use DartComm\Model\Identity;
use DartComm\Comm\Protocol\Imap;

class IndexController extends Action
{
    public function indexAction()
    {
     	$identity = new Identity('host', 'un', 'pw', '993', true, false);
     	$imap = new Imap($identity);
     	$mboxes = $imap->getMailboxes();
     	$mbox = $imap->getAll($mboxes[20], 0, 20);
     	foreach($mbox as $i => $e) {
     		echo $e->Subject.'<br/>';
     	}
     	$msgid = 3;
     	$msg = $imap->getStructure($msgid);

     	if (isset($msg->parts)) {
	     	foreach($msg->parts as $partid => $part) {
	     		switch ($part->type) {
	     			case TYPETEXT:
			     		$body = $imap->getPart($msgid, $partid);
			     		switch($part->encoding) {
			     			case ENCQUOTEDPRINTABLE:
			     				echo '<pre>'.quoted_printable_decode($body).'</pre>';
			     				break;
			     			case ENC7BIT:
			     				echo '<pre>'.mb_convert_encoding($body, 'UTF-8', 'UTF-7').'</pre>';
			     			default:
			     				echo 'Unsupported encoding: .'.$part->encoding;
			     				break;
			     		}
			     		break;
			     	case TYPEMULTIPART:
			     		foreach($part->parts as $subpartid => $subpart) {
			     			switch ($subpart->type) {
				     			case TYPETEXT:
						     		$body = $imap->getPart($msgid, $subpartid);
						     		switch($subpart->encoding) {
						     			case ENCQUOTEDPRINTABLE:
						     				echo '<pre>'.quoted_printable_decode($body).'</pre>';
						     				break;
						     			case ENC7BIT:
						     				echo '<pre>'.mb_convert_encoding($body, 'UTF-8', 'UTF-7').'</pre>';
						     			default:
						     				echo 'Unsupported encoding: .'.$part->encoding;
						     				break;
						     		}
						     		break;
						     	default:
						     		echo 'Unknown TYPE: '.$part->type;
						     }
			     		}
			     		break;
			     	default:
			     		echo 'Unknown TYPE: '.$part->type;
			     }
	     	}
	     } else {
	     	$body = $imap->getPart($msgid, 1);
	     	echo '<pre>'.$body.'</pre>';
	     }
     	

    }
}
