printing
printOn: aStream

	super printOn: aStream.
	aStream
		nextPutAll: '(';
		nextPutAll: 'fieldName='; nextPutAll: fieldName printString;
		nextPutAll: ',typeOid='; nextPutAll: typeOid printString;
		nextPutAll: ',typeSize='; nextPutAll: typeSize printString;
		nextPutAll: ',typeModifier='; nextPutAll: typeModifier printString;
		nextPutAll: ')'
