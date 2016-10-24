printing
printOn: aStream

	super printOn: aStream.
	aStream
		nextPutAll: '(';
		nextPutAll: 'oid='; nextPutAll: oid printString;
		nextPutAll: ',arguments='; nextPutAll: arguments printString;
		nextPutAll: ')'