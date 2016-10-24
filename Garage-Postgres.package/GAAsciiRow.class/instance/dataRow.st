accessing
dataRow

	| converters converter data dictionary index |

	converters := description resultSet result connection fieldConverters.
	dictionary := description columnDescriptionDictionary.
	data := GADataRow for: dictionary.
	index := 0.
	rawData with: description columnDescriptions do: [ :each :aColumnDescription |
		data
			at: (index := index + 1)
			put: (
				each ifNotNil: [
					(converter := converters at: aColumnDescription typeOid ifAbsent: nil)
						ifNil: [ each ]
						ifNotNil: [ converter reentrant value: each ] ]) ].
	^data
