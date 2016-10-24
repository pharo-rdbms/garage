private
readIntegerFrom: readStream

	| next result sign |
	readStream atEnd ifTrue: [ ^self parseError ].
	readStream peek caseOf: {
		[ $- ] -> [
			sign := -1.
			readStream skip: 1 ].
		[ $N ] -> [
			(readStream next: 4) = 'NULL' ifTrue: [ ^nil].
			self parseError ]}
		otherwise: [ sign := 1 ].
	result := 0.
	[ (next := readStream next) == nil or: [
		(next := next asciiValue - 48) < 0 or: [
			next > 9 ] ] ] whileFalse: [
		result := result * 10 + next ].
	readStream skip: -1.
	^result * sign
