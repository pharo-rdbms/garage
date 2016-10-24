receiving
receiveFrom: connection

	| emptyFlag resultSize |
	emptyFlag := connection next codePoint.
	emptyFlag == 71  "$G codePoint == 71 indicates non-void response"
		ifTrue: [
			resultSize := self readInt32From: connection.
			result := ByteArray new: resultSize.
			1 to: resultSize do: [:i | result at: i put: connection next codePoint].
			connection next. "toss the extra 0 byte"
	].
