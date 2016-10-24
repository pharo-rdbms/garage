as yet unclassified
doesNotUnderstand: aMessage

	^self at: (
		dictionary 
			at: aMessage selector
			ifAbsent: [ ^super doesNotUnderstand: aMessage ])