printing
displayOn: aStream

	columnDescriptions withIndexDo: [:each :i |
		each displayOn: aStream.
		i < columnDescriptions size ifTrue: [aStream space].
	].
