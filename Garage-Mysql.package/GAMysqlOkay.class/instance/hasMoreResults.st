as yet unclassified
hasMoreResults
	^ (serverStatus bitAnd: GAMysqlServerStatusConstants moreResultsExist) ~= 0
	