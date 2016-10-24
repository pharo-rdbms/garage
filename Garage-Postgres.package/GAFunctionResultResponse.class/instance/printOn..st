printing
printOn: aStream

	super printOn: aStream.
	aStream
		nextPutAll: '(';
		nextPutAll: 'result='; nextPutAll: result printString;
		nextPutAll: ')'