<?php
namespace Application\Controller;

use Zend\Mvc\Controller\AbstractActionController as Action;
use DartComm\Model\Server;
use DartComm\Model\Identity;

class IndexController extends Action
{
    public function indexAction()
    {
        $server = new Server('mail.google.com', 993, true, false);
        $identity = new Identity('medwan7', 'mypw71s!!');
        $connection = $server->authenticate($identity);
        
        $arrMailboxes = $connection->getMailboxes();
    	foreach($arrMailboxes as $mailbox) {
    		echo $mailbox->getName().' : '.$mailbox->count();
        }

        $mailbox = $connection->getMailbox('INBOX');

        foreach($mailbox->getAll() as $message) {
    		  echo $message->getBodyHtml();
    	      return;
        }
    }
}
