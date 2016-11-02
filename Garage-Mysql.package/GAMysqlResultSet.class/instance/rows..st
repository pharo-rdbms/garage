accessing
rows: allRows

	allRows ifNil: [ ^ self ].
	rows addAll: allRows asOrderedCollection