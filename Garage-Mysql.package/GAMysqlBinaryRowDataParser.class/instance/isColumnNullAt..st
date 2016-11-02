testing
isColumnNullAt: index
	| byteIndex bitsToShift bitMask |
	byteIndex := index + 9 // 8.
	bitsToShift := index + 9 \\ 8.
	bitMask := 1 << bitsToShift.
	
	^ ((nullBitMap at: byteIndex) bitAnd: bitMask) ~= 0
	
	