as yet unclassified
bytesFromHexString: hexString
	| strm bytes aByte ii high low hexAlphabet |
	(hexString size \\ 2 = 0) ifFalse: [self error: 'Not proper hex encoding'].
	strm := ReadStream on: hexString.
	
	bytes := ByteArray new: (hexString size // 2).

	hexAlphabet := '0123456789ABCDEF'.
	ii := 1.
	[strm atEnd] whileFalse: [
		high := (hexAlphabet indexOf: (strm next asUppercase)) - 1.
		low := (hexAlphabet indexOf: (strm next asUppercase)) - 1.
		aByte :=   high * 16 + low.
		bytes at: ii put: aByte.
		ii := ii + 1].

	^ bytes
	