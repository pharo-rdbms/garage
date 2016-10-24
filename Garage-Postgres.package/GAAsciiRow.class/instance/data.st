accessing
data

	| converters converter data |

	converters := description resultSet result connection fieldConverters.
	data := OrderedCollection new.
	rawData with: description columnDescriptions do: [:each :aColumnDescription |
		data addLast: (
			each isNil
				ifTrue: [nil]
				ifFalse: [
					converter := converters at: aColumnDescription typeOid ifAbsent: [nil].
					converter isNil ifTrue: [ each ] ifFalse: [ converter value: each ].
				]).
	].
	^data
