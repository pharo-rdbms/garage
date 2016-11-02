private
longIntRange
	^ self isDeclaredUnsigned 
		ifTrue: [16r00000000 to: 16rFFFFFFFF] 
		ifFalse: [-16r80000000 to: 16r7FFFFFFF].
