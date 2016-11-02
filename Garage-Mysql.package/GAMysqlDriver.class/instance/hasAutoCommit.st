testing
hasAutoCommit
	
	^ ((self execute: 'SHOW SESSION VARIABLES LIKE ''autocommit''')
		first atName: 'Value') = 'ON'.