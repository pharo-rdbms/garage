accessing
valueAt: fieldName

	| i |
	i := rowDescription columnDescriptions findFirst: [:each | each fieldName = fieldName].
	i = 0 ifTrue: [^ nil].
	rows == nil ifTrue: [^ nil].
	^ (rows at: 1) rawData at: i