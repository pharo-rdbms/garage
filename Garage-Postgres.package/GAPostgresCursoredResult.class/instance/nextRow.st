as yet unclassified
nextRow
	
	self halt.
	(rows isEmpty and: [ finished not ])
		ifTrue: [ self fetchRows ].

	^ rows isEmpty
		ifTrue: [ nil ]
		ifFalse: [ rows removeFirst ]