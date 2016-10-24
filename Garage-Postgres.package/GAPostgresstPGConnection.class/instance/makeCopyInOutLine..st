tests
makeCopyInOutLine: aCollection

	| ws |
	ws := WriteStream on: (String new: 512).
	aCollection withIndexDo: [:each :i |
		ws nextPutAll: each.
		i < aCollection size ifTrue: [ws tab]
	].
	ws nextPut: Character lf.
	^ ws contents.
