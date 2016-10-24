printing
displayOn: aStream

	rawData withIndexDo: [:each :i |
		aStream nextPutAll: (each == nil ifTrue: ['0'] ifFalse: [each]).
		i < rawData size ifTrue: [aStream space].
	].
