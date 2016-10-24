printing
displayResultOn: aStream

	errorResponse ifNotNil: [
		aStream nextPutAll: errorResponse value.
		aStream cr].

	resultSets do: [:each | each displayResultSetOn: aStream].
