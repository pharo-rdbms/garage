printing
printOn: aStream

	super printOn: aStream.
	aStream
		nextPutAll: '(';
		nextPutAll: 'type='; nextPutAll: type printString;
		nextPutAll: ',salt='; nextPutAll: salt printString;
		nextPutAll: ')'
