as yet unclassified
columnDescriptionDictionary

	^columnDescriptionDictionary ifNil: [
		columnDescriptionDictionary := IdentityDictionary new.
		columnDescriptions doWithIndex: [ :each :i |
			columnDescriptionDictionary at: each fieldName asSymbol put: i ].
		columnDescriptionDictionary ]