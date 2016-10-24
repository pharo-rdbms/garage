printing
printOn: aStream

	super printOn: aStream.
	aStream
		nextPutAll: '(';
		nextPutAll: 'databaseName='; nextPutAll: databaseName printString;
		nextPutAll: ',userName='; nextPutAll: userName printString;
		nextPutAll: ',extraArgs='; nextPutAll: extraArgs printString;
		nextPutAll: ',debugTty='; nextPutAll: debugTty printString;
		nextPutAll: ',version='; nextPutAll: version printString;
		nextPutAll: ')'
