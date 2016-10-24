receiving
receiveFrom: connection

	numberOfColumns := self readInt16From: connection.
	1 to: numberOfColumns do: [:i |
		columnDescriptions add: (GAColumnDescription new receiveFrom: connection; yourself).
	].
