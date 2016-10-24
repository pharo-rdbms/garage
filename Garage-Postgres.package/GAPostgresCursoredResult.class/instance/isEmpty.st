testing
isEmpty
	
	^ rows isEmptyOrNil
		and: [ self hasMoreRowsInServer not ]