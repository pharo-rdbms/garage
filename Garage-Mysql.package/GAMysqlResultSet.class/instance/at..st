iterating
at: anInteger 
	
	[(self hasRowAt: anInteger) not and: [ self canFetchMoreRows ]]
		whileTrue: [ self fetchMoreRows ].
	^ self internalRows at: anInteger