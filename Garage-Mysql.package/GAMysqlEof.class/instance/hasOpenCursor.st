as yet unclassified
hasOpenCursor
	^ (serverStatus bitAnd: GAMysqlServerStatusConstants statusCursorExists) ~= 0
	