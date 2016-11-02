as yet unclassified
inTransaction
	| autoCommit inTx |
	autoCommit := (serverStatus bitAnd: GAMysqlServerStatusConstants statusInTransaction) ~= 0.
	inTx := (serverStatus bitAnd: GAMysqlServerStatusConstants statusInTransaction) ~= 0.
	^ autoCommit and: inTx
	