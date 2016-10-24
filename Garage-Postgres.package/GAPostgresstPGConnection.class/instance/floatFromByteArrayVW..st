private
floatFromByteArrayVW: aByteArray
	"Convert aByteArray to a Float."

	| aFloat |
	aFloat := ByteArray new: 8.
	1 to: 8 do: [:i | aFloat at: 8 - i + 1 put: (aByteArray at: i)].
	aFloat changeClassTo: Double.
	^aFloat