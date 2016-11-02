as yet unclassified
nullBitMap
	| nullBitMap mapByte byteIndex bitMask |
	nullBitMap := ByteArray new: (params size + 7) // 8.
	params doWithIndex: [:each :paramIndex |
		each isNull ifTrue: [
			byteIndex := (paramIndex + 7) // 8.
			bitMask := 1 bitShift: (paramIndex + 7) \\ 8.
			mapByte := nullBitMap at: byteIndex.
			mapByte := mapByte bitOr: bitMask.
			nullBitMap at: byteIndex put: mapByte.
		]
	].

	^ nullBitMap 
	