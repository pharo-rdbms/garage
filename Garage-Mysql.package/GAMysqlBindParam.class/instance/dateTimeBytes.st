writes
dateTimeBytes
	| dt year length micros |
	ByteArray streamContents: [:strm |
		dt := paramValue asDateAndTime.
		length := 0.
		strm nextPut: length. "will re-adjust this as different conditions are found"
				
		year := dt year.
		strm 
			nextPut: (year digitAt: 1); nextPut: (year digitAt: 2); "year"
			nextPut: (dt month digitAt: 1); nextPut: (dt dayOfMonth digitAt: 1).

		strm
			nextPut: (dt hour digitAt: 1); nextPut: (dt minute digitAt: 1); 
			nextPut: (dt second digitAt: 1). 
		
		micros := dt nanoSecond // 1000.
		strm 
			nextPut: (micros digitAt: 1); nextPut: (micros digitAt: 2);
			nextPut: (micros digitAt: 3); nextPut: (micros digitAt: 4).
		
		"Update the length field now."
		length := 11.
		micros = 0 ifTrue: [
			length := 7. "no sub-seconds to send"
			(((dt hour = 0) and: [dt minute = 0]) and: [dt second = 0]) ifTrue: [
				"no hh:mm:ss to send"
				length := 4.				
				((dt year = 0) and: [dt month = 0 and: [dt day = 0]]) ifTrue: [
					"no yy-mm-dd to send"
					length := 0]]].
		
		strm reset; nextPut: length; setToEnd.
		^ strm contents first: (length + 1) "remember to send the length byte itself" ]
	