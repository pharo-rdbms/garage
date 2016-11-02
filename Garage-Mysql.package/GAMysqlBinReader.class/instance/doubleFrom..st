real
doubleFrom: aStream
	| num |
	num := Float new: 2.
	num at: 2 put: (self longIntFrom: aStream).
	num at: 1 put: (self longIntFrom: aStream).
	^ num
	
