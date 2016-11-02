writing
writeTo: aStream
	length = data size ifFalse: [self error: 'Mismatch between packet length and data size'].

	aStream 
		nextPut: (length digitAt: 1);
		nextPut: (length digitAt: 2);
		nextPut: (length digitAt: 3).
		
	aStream nextPut: (number digitAt: 1)	.
	
	(aStream respondsTo: #nextPutAllFlush:)  "socket streams respond to this"
		ifTrue: [aStream nextPutAllFlush: data] "this one avoids some data copy"
		ifFalse: [aStream nextPutAll: data; flush]