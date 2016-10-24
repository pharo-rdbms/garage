cursor
fetchAllRows

	[ self hasMoreRowsInServer ] whileTrue: [ self fetchMoreRows ]