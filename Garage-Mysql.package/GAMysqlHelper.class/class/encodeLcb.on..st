as yet unclassified
encodeLcb: value on: aStream 
	value < -1 ifTrue: 
		[ self error: 'Can not encode value' , value asString , ' to length coded binary' ].
	value = -1 ifTrue: 
		[ "represents null column value"
		^ aStream nextPut: 251 ].
	(value 
		between: 0
		and: 250) ifTrue: [ ^ aStream nextPut: (value digitAt: 1) ].
	value <= 65535 ifTrue: 
		[ ^ aStream
			nextPut: 252;
			nextPut: (value digitAt: 1);
			nextPut: (value digitAt: 2) ].
	value <= 16777215 ifTrue: 
		[ ^ aStream
			nextPut: 253;
			nextPut: (value digitAt: 1);
			nextPut: (value digitAt: 2);
			nextPut: (value digitAt: 3)
			yourself].
	^ aStream
		nextPut: 254;
		nextPut: (value digitAt: 1);
		nextPut: (value digitAt: 2);
		nextPut: (value digitAt: 3);
		nextPut: (value digitAt: 4);
		nextPut: (value digitAt: 5);
		nextPut: (value digitAt: 6);
		nextPut: (value digitAt: 7);
		nextPut: (value digitAt: 8);
		yourself