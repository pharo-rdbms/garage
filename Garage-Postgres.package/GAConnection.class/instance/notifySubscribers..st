private-actions
notifySubscribers: pkt

	notificationSubscribers isNil
		ifTrue: [ self logInfo: 'NOTIFICATION: ', pkt printString ]
		ifFalse: [ notificationSubscribers do: [:each | each receive: pkt from: self ]].
