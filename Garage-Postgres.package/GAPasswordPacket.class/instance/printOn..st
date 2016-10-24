printing
printOn: aStream

	super printOn: aStream.
	aStream
		nextPutAll: '(';
		nextPutAll: 'password='; nextPutAll: password printString;
		nextPutAll: ')'