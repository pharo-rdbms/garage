private
floatFromByteArray: aByteArray
	"Convert aByteArray to a Float."

	| word1 word2 aFloat |

	word1 := (aByteArray at: 1) bitShift: 24.
	word1 := word1 bitOr: ((aByteArray at: 2) bitShift: 16).
	word1 := word1 bitOr: ((aByteArray at: 3) bitShift: 8).
	word1 := word1 bitOr: ((aByteArray at: 4) bitShift: 0).
	word2 := (aByteArray at: 5) bitShift: 24.
	word2 := word2 bitOr: ((aByteArray at: 6) bitShift: 16).
	word2 := word2 bitOr: ((aByteArray at: 7) bitShift: 8).
	word2 := word2 bitOr: ((aByteArray at: 8) bitShift: 0).

	aFloat := 0.0.
	aFloat basicAt: 1 put: word1.
	aFloat basicAt: 2 put: word2.
	^aFloat