receiving
readBitmap: nbits from: connection

	| nbytes bitmap |

	nbytes := (nbits + 7) // 8.
	bitmap := ByteArray new: nbytes.
	1 to: nbytes do: [:i |
		bitmap at: i put: connection next codePoint.
	].
	^bitmap
