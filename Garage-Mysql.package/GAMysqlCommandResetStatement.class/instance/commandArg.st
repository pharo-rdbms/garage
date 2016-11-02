as yet unclassified
commandArg
	ByteArray streamContents: [:strm |
		strm 
		nextPut: (statementId digitAt: 1);
		nextPut: (statementId digitAt: 2);
		nextPut: (statementId digitAt: 3);
		nextPut: (statementId digitAt: 4).
		
		^ strm contents]