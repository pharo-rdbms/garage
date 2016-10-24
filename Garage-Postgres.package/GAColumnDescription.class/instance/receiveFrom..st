receiving
receiveFrom: connection

	fieldName := self readStringFrom: connection.
	typeOid := self readInt32From: connection.
	typeSize := self readInt16From: connection.
	typeModifier := self readInt32From: connection.
