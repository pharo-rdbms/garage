as yet unclassified
default
	defaultInstance isNil ifTrue: [ defaultInstance := self new ].
	^ defaultInstance