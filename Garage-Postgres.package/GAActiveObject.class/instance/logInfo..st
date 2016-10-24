trace
logInfo: text

	Transcript
		nextPut: $[;
		nextPutAll: self logIdString;
		nextPut: $];
		space;
		nextPutAll: text;
		cr;
		flush.
