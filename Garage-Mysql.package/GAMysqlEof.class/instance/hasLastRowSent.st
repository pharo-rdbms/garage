as yet unclassified
hasLastRowSent
	^ (serverStatus bitAnd: GAMysqlServerStatusConstants statusLastRowSent) ~= 0
	