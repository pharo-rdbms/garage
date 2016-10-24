printing
printOn: aStream

	super printOn: aStream.
	aStream nextPutAll: '('; cr.
	columnDescriptions do: [:each | each printOn: aStream. aStream cr].
	aStream nextPutAll: ')'.
