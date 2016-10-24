receiving
receiveFrom: connection

	processId := self readInt32From: connection.
	conditionName := self readStringFrom: connection.
