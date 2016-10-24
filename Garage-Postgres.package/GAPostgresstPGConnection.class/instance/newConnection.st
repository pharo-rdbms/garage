private
newConnection

	| conn |

	conn := GAConnection new.
	(useConnectionDefaults isNil or: [useConnectionDefaults not])
		ifTrue: [ conn connectionArgs: GAConnection buildDefaultConnectionArgs ]
		ifFalse: [ GAConnection defaultConnectionArgs: nil. conn connectionArgs: nil ].
	(notificationSubscriberCount notNil and: [notificationSubscriberCount > 0 ])
		ifTrue: [
			1 to: notificationSubscriberCount do: [:i |
				conn addNotificationSubscriber: GANotificationSubscriber new]
		].
	^ conn
