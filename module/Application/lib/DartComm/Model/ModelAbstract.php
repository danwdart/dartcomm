<?php
namespace DartComm\Model;

abstract class ModelAbstract
{
	private $_arrData;

	protected function _setField($strField, $mixedValue)
	{
		$this->_arrData[$strField] = $mixedValue;
		return $this;
	}

	protected function _getField($strField, $mixedDefault)
	{
		return isset($this->_arrData[$strField])?
			$this->_arrData[$strField]:
			$mixedDefault;
	}

	public function __get($strField)
	{
		return $this->_getField($strField, null);
	}

	public function __set($strField, $mixedValue)
	{
		$this->_setField($strField, $mixedValue);
		return $this;
	}
}