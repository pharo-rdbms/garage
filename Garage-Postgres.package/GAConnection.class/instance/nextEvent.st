private-actions
nextEvent

	| pkt noticeFlag |

	[
		pkt := self receivePacket.
		(noticeFlag := #(NoticeResponse NotificationResponse) includes: pkt eventName)
			ifTrue: [ self notifySubscribers: pkt ].
		noticeFlag.
	] whileTrue.
	^ pkt
