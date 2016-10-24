converters
booleanArrayConverter

	^[ :s | 
		| readStream |
		readStream := s readStream.
		readStream next.
		Array streamContents: [ :stream | 
			[ readStream atEnd or: [ readStream peek = $} ] ] whileFalse: [
				stream nextPut: (self nextBooleanFrom: readStream) ] ] ].

