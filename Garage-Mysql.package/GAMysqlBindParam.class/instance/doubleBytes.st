writes
doubleBytes 
	| storable |
	ByteArray streamContents: [:strm |
		storable := paramValue asFloat at: 1.
		strm 
			nextPut: (storable digitAt: 1); nextPut: (storable digitAt: 2);
			nextPut: (storable digitAt: 3); nextPut: (storable digitAt: 4).

		storable := paramValue asFloat at: 2.
		strm 
			nextPut: (storable digitAt: 1); nextPut: (storable digitAt: 2);
			nextPut: (storable digitAt: 3); nextPut: (storable digitAt: 4).
			
		^ strm contents]
