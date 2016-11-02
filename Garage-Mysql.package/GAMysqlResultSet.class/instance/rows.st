cursor
rows

	[ self canFetchMoreRows ] whileTrue: [ self fetchMoreRows ].
	^ self internalRows