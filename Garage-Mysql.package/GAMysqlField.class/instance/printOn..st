as yet unclassified
printOn: aStream

	aStream
		nextPutAll: self class name;
		nextPut: $(;
		nextPutAll: self name;
		nextPut: $).