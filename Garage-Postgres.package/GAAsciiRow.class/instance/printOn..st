printing
printOn: aStream

	super printOn: aStream.
	aStream nextPutAll: '('.
	rawData do: [:each | each printOn: aStream. aStream nextPut: $,].
	aStream skip: -1; nextPutAll: ')'.
