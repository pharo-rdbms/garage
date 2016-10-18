iterating
rows

	| row |
	"we cache the result"
	rows ifNotNil: [ ^ rows ].
	
	rows := OrderedCollection new.
	[ row := self next. row notNil ] whileTrue: [ rows add: row ].
	^ rows