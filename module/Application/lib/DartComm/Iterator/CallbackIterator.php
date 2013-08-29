<?php

namespace DartComm\Iterator;

class CallbackIterator extends \IteratorIterator
{
	private $_closure;

	public function __construct(\Traversable $innerIterator, \Closure $closure)
	{
		parent::__construct($innerIterator);
		$this->_closure = $closure;
	}

	public function current()
	{
		return $closure(parent::current());
	}
}