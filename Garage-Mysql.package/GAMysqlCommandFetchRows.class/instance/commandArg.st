as yet unclassified
commandArg
	| |
	ByteArray streamContents: 
		[ :strm | 
		strm
			nextPut: (stmtId digitAt: 1);
			nextPut: (stmtId digitAt: 2);
			nextPut: (stmtId digitAt: 3);
			nextPut: (stmtId digitAt: 4);
			nextPut: (numRows digitAt: 1);
			nextPut: (numRows digitAt: 2);
			nextPut: (numRows digitAt: 3);
			nextPut: (numRows digitAt: 4).
			
		^ strm contents ]