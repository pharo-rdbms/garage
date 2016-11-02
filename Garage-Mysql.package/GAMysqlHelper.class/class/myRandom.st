private
myRandom
	seedOne := (seedOne * 3 + seedTwo) \\ maxValue.
	seedTwo := (seedOne + seedTwo + 33) \\ maxValue.
	
	^ (seedOne / maxValue) asFloat
	