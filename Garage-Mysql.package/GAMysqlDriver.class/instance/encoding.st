encoding
encoding
	
	| encoding |
	encoding := connectionString optionAt: 'encoding' ifAbsent: 'utf8mb4'.
	^ (encoding = 'utf8') ifTrue: [ 'utf8mb4' ] ifFalse: [ encoding ]