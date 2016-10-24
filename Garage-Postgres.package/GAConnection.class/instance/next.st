private-actions
next
	readIndex >= lastReadIndex 
		ifTrue: 
			[trace >= 10 
				ifTrue: [self log: 'next' text: '**** filling read buffer ****'].
			"(Delay forMilliseconds: 500) wait."
			socket waitForData. "For: Socket standardTimeout."
			
			[(lastReadIndex := socket receiveDataInto: readBuffer) = 0 
				ifTrue: 
					[trace >= 10 
						ifTrue: [self log: 'next' text: '**** zero length received from socket ****'].
					(Delay forMilliseconds: 100) wait].
			lastReadIndex = 0] 
					whileTrue.
			readIndex := 0.
			trace >= 10 
				ifTrue: 
					[self log: 'next' text: '**** read ' , lastReadIndex printString , ' ****']].
	readIndex := readIndex + 1.
	trace >= 10 
		ifTrue: 
			[self log: 'next'
				text: 'readIndex=' , readIndex printString , ',lastReadIndex=' 
						, lastReadIndex printString , ',ch=' 
						, (readBuffer at: readIndex) printString].
	^readBuffer at: readIndex