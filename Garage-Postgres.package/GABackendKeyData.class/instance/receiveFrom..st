receiving
receiveFrom: aStream

	processId := self readInt32From: aStream.
	secretKey := self readInt32From: aStream.
