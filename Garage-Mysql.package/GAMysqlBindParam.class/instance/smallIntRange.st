private
smallIntRange
	^ self isDeclaredUnsigned ifTrue: [16r0000 to: 16rFFFF] ifFalse: [-16r8000 to: 16r7FFF].
