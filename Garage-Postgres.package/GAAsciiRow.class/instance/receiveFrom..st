receiving
receiveFrom: connection

	| ncol |

	description := connection result rowDescription.
	ncol := description numberOfColumns.
	nullFields := self readBitmap: ncol from: connection.
	0 to: ncol - 1 do: [:i |
		((nullFields at: (i // 8) + 1) bitAnd: (2r10000000 bitShift: (i \\ 8) negated)) > 0
			ifTrue: [rawData add: (self readFieldFrom: connection)]
			ifFalse: [rawData add: nil].
	].
