<?php

namespace DartComm\Iterator;

class ObjectIterator extends \IteratorIterator
{
	private $_strClass;

	public function __construct(\Traversable $innerIterator, $strClass)
	{
		parent::__construct($innerIterator);
		$this->_strClass = $strClass;
	}

	public function current()
	{
		$strClass = $this->_strClass;
		return new $strClass(parent::current());
	}
}