private
asFloat8Arg: aFloat
	"Convert aFloat to a ByteArray for use as a function call argument."

	| word1 word2 bigEndian arg tmp |

	word1 := aFloat basicAt: 1.
	word2 := aFloat basicAt: 2.
	bigEndian := false.
	bigEndian ifTrue: [
			tmp := word1.
			word1 := word2.
			word2 := tmp.
		].
	arg := ByteArray new: 8.
	arg at: 1 put: ((word1 bitShift: -24) bitAnd: 16rFF).
	arg at: 2 put: ((word1 bitShift: -16) bitAnd: 16rFF).
	arg at: 3 put: ((word1 bitShift: -8) bitAnd: 16rFF).
	arg at: 4 put: ((word1 bitShift: 0) bitAnd: 16rFF).
	arg at: 5 put: ((word2 bitShift: -24) bitAnd: 16rFF).
	arg at: 6 put: ((word2 bitShift: -16) bitAnd: 16rFF).
	arg at: 7 put: ((word2 bitShift: -8) bitAnd: 16rFF).
	arg at: 8 put: ((word2 bitShift: 0) bitAnd: 16rFF).
	^ arg
