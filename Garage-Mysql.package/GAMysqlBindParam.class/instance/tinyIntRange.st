private
tinyIntRange
	^ self isDeclaredUnsigned ifTrue: [16r00 to: 16rFF] ifFalse: [-16r80 to: 16r7F].
