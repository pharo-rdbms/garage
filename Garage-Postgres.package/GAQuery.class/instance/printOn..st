printing
printOn: aStream

	super printOn: aStream.
	aStream
		nextPutAll: '(';
		nextPutAll: 'queryString='; nextPutAll: queryString printString;
		nextPutAll: ')'