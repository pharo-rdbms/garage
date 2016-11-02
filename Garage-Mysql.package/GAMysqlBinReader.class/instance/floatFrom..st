real
floatFrom: aStream
	^ Float fromIEEE32Bit: (self longIntFrom: aStream)
	