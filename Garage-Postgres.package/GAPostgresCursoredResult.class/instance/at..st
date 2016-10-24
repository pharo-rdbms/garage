iterating
at: anIndex
	
	"Ok we should optimize it later"
	self fetchWhile: [ rows size < anIndex ].
	^ rows at: anIndex