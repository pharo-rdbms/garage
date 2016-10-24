printing
printOn: aStream

	super printOn: aStream.
	aStream
		nextPutAll: '(';
		nextPutAll: 'value='; nextPutAll: value printString;
		nextPutAll: ')'
