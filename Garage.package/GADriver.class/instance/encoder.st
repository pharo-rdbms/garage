encoding
encoder
	
	| theEncoding |
	"Returns a Zn encoder corresponding to the configured encoding.
	Default: 'utf8'"
	theEncoding := (self encoding = 'utf8mb4') ifTrue: [ 'utf8' ] ifFalse: [ self encoding ].
	^ ZnCharacterEncoder newForEncoding: theEncoding