as yet unclassified
commandArg
	| paramType nonLongs |
	ByteArray streamContents: 
		[ :strm | 
		strm
			nextPut: (stmtId digitAt: 1);
			nextPut: (stmtId digitAt: 2);
			nextPut: (stmtId digitAt: 3);
			nextPut: (stmtId digitAt: 4).
		cursoredFetch 
			ifTrue: [ strm nextPut: 1	"flags => READ_CURSOR" ]
			ifFalse: [ strm nextPut: 0	"flags => NO_CURSOR" ].
		strm
			nextPut: 1;
			nextPut: 0;
			nextPut: 0;
			nextPut: 0.	"iterationCount"
		strm nextPutAll: self nullBitMap.
		self hasNewParamBound 
			ifTrue: 
				[ strm nextPut: 1.	"new params bound <- true"
				params do: 
					[ :each | 
					paramType := each paramType.
					strm
						nextPut: (paramType digitAt: 1);
						nextPut: (paramType digitAt: 2) ] ]
			ifFalse: [ strm nextPut: 0 ].	"new params bound <- false"
		nonLongs := params 
			ifNil: [ Array new ]
			ifNotNil: [ params reject: [ :each | each isLongData ] ].
		nonLongs do: [ :each | each storeBinaryOn: strm ].
		^ strm contents ]