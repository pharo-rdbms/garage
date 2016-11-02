private
bigIntRange
	^ self isDeclaredUnsigned 
		ifTrue: [16r0000000000000000 to: 16rFFFFFFFFFFFFFFFF] 
		ifFalse: [-16r8000000000000000 to: 16r7FFFFFFFFFFFFFFF].
