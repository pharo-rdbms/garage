cursor management
declare

	connection execute: 'DECLARE ', name, ' CURSOR FOR ', statement executionStatement.
	fetchListener ifNotNil: #fetchOccurred.