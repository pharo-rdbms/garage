private
nextBooleanFrom: readStream

	| firstChar result |
	firstChar := readStream next.
	result := firstChar caseOf: { 
		[ $t ] -> [ true ].
		[ $T ] -> [ true ].
		[ $f ] -> [ false ].
		[ $F ] -> [ false ].
		[ $N ] -> [ 
			(readStream next: 3) = 'ULL' ifFalse: [
				self parseError ].
			nil ] }.
	readStream skip: 1.
	^result