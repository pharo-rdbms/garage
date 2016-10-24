conversion
pgGoodQuery: aQuery
	
	| goodQuery next index lastIndex |
	goodQuery := ''.
	lastIndex := 0.
	next := 1.
	[index := aQuery findString: '?' startingAt: lastIndex + 1 caseSensitive: true. index = 0] 
		whileFalse: [
			goodQuery := goodQuery , (aQuery copyFrom: lastIndex + 1 to: index -1).
			goodQuery := goodQuery , '$', next asString.
			lastIndex := index.
			next := next + 1 ].
	goodQuery := goodQuery , (aQuery copyFrom: lastIndex + 1 to: aQuery size).
	^ goodQuery