public
basicExecute: aBlock
	| ret |
	
	ret := self step. 
	(ret = 101) " == SQLITE_DONE, meaning step should not be sent again."
		ifTrue: [ aBlock value: self ]
		ifFalse: [
			[ ret = 100 ] whileTrue: [ " == SQLITE_ROW, meaning another row is available."
				aBlock value: self.
				ret := self step ]]