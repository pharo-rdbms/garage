printing
printOn: aStream
	super printOn: aStream.
	aStream << ' ('.
	self resultSets do: [ :item | item printOn: aStream ] separatedBy: [ aStream << ', ' ].
	aStream << ')'