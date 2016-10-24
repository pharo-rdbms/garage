private
asFloat8ArgVW: aFloat
	"Convert aFloat to a ByteArray for use as a function call argument."

	| arg |
	arg := ByteArray new: 8.
	1 to: 8 do: [:i | arg at: i put: (aFloat basicAt: 8 - i + 1)].
	^arg