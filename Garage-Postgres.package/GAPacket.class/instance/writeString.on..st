sending
writeString: aString on: aStream

	aStream
		nextPutAll: aString;
		nextPut: (Character value: 0);
		yourself.

