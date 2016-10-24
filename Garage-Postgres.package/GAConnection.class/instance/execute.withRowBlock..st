api
execute: sqlString withRowBlock: aRowBlock
	"Iterate thru resultset with block (for each row) without loading all bulk resultset data into memory (internal arrays). Implemented by database CURSORs.
	Row block has 2 parameters: 
		1) row description (PGRowDescription - column names, data types etc.)
		2) row data (OrderedCollection)"
	| cursorName rslt rowDesc rows |
	cursorName := 'squeakTempCursor', Time now nanoSecond asString.
	self executeAndCheckResult: 'BEGIN WORK'.
	[ 	self executeAndCheckResult: 'DECLARE ', cursorName, ' CURSOR FOR ', sqlString asString.
		[ 
			[	rslt := self executeAndCheckResult: 'FETCH FORWARD 5000 FROM ', cursorName.
				rowDesc := rslt resultSets first rowDescription.
				rows := rslt resultSets first rows.
				rows size > 0.
			] whileTrue: [
				rows do: [ :row | aRowBlock value: rowDesc value: row data ].				
				].						
		] ensure: [ self executeAndCheckResult: 'CLOSE ', cursorName ]
	] ensure: [ self executeAndCheckResult: 'COMMIT WORK' ].
	
