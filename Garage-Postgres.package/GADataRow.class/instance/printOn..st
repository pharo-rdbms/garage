as yet unclassified
printOn: aStream

	super printOn: aStream.
	aStream nextPut: $(.
	(dictionary associations
		sort: [ :a :b | a value < b value ])
		do: [ :assoc |
			aStream 
				nextPutAll: assoc key;
				nextPutAll: ': ';
				print: (self at: assoc value) ]
		separatedBy: [ aStream nextPutAll: ', ' ].
	aStream nextPut: $)