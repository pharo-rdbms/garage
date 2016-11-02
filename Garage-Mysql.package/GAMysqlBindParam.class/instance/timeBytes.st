writes
timeBytes
	| dur days length micros |
	ByteArray streamContents: [:strm |
		dur := paramValue asDuration.
		length := 0.
		strm nextPut: length. "will re-adjust this as different conditions are found"
				
		dur negative ifTrue: [strm nextPut: 1] ifFalse: [strm nextPut: 0].

		days := dur days.
		strm 
			nextPut: (days digitAt: 1); nextPut: (days digitAt: 2);
			nextPut: (days digitAt: 3); nextPut: (days digitAt: 4).
		
		strm 
			nextPut: (dur hours digitAt: 1); nextPut: (dur minutes digitAt: 1); 
			nextPut: (dur seconds asInteger digitAt: 1).
		
		micros := dur nanoSeconds // 1000.
		strm 
			nextPut: (micros digitAt: 1); nextPut: (micros digitAt: 2);
			nextPut: (micros digitAt: 3); nextPut: (micros digitAt: 4).
		
		"Update the length field now."
		length := 11.
		micros = 0 ifTrue: [
			length := 7. "no sub-seconds to send"
			((dur hours = 0) and: [dur minutes = 0 and: [dur seconds = 0]]) ifTrue: [
				"no hh:mm:ss to send"
				length := 4.
				dur days = 0 ifTrue: [length := 0]]].
		 
		length > 0 ifTrue: [length := length + 1 "include sign byte"].
		strm reset; nextPut: length; setToEnd.
		^ strm contents first: (length + 1)] "length byte plus rest"
	