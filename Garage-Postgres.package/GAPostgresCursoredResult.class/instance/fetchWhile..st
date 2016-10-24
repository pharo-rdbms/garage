cursor
fetchWhile: aBlock

	[ self hasMoreRowsInServer and: aBlock ] whileTrue: [ self fetchMoreRows ]