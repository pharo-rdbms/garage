writes
floatBytes 
	| storable |
	ByteArray streamContents: [:strm |
		storable := paramValue asFloat at: 1. "indexed accedd into a Float"
		strm 
			nextPut: (storable digitAt: 1); nextPut: (storable digitAt: 2);
			nextPut: (storable digitAt: 3); nextPut: (storable digitAt: 4).
		^ strm contents]
	