query
prepare: aQuery
	
	^ (self createStatement: aQuery) prepare