receiving
readInt32From: connection

	| value |

	value := connection next codePoint.
	value := (value bitShift: 8) bitOr: connection next codePoint.
	value := (value bitShift: 8) bitOr: connection next codePoint.
	value := (value bitShift: 8) bitOr: connection next codePoint.
	^value
