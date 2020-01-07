Class {
	#name : #GAMysqlNetSession,
	#superclass : #Object,
	#instVars : [
		'theStream',
		'nextPacketNumber',
		'peekData'
	],
	#category : 'Garage-MySQL-Protocol'
}

{ #category : #testing }
GAMysqlNetSession >> connected [
	^ theStream ifNil: [false] ifNotNil: [theStream isConnected] 
]

{ #category : #accessing }
GAMysqlNetSession >> disconnect [
	theStream isConnected ifTrue: [theStream close] .

]

{ #category : #'sequence numbering' }
GAMysqlNetSession >> getSequence [
	^ nextPacketNumber 
]

{ #category : #'initialize-release' }
GAMysqlNetSession >> initialize [
	self resetSequence.

]

{ #category : #reading }
GAMysqlNetSession >> peek [
	"Look ahead; don't remove the packet until next read"
	peekData ifNil: [peekData := self readPacketData].
	^ peekData
]

{ #category : #reading }
GAMysqlNetSession >> read [
	| data |
	"Return packet from look ahead buffer if any. Clear look ahead buffer"
	peekData ifNotNil: [data := peekData. peekData := nil. ^ data].
	^ self readPacketData
	
]

{ #category : #reading }
GAMysqlNetSession >> readNetPacket [
	| pkt |
	pkt := GAMysqlNetPacket new.
	pkt readFrom: theStream.
	self validatePacket: pkt.
	^ pkt
]

{ #category : #reading }
GAMysqlNetSession >> readPacketData [
	"Read all packets until there is no more packets of data."
	| dataPackets pkt totalSize buffer ii |
	dataPackets := OrderedCollection new.
	
	[ pkt := self readNetPacket.
	dataPackets add: pkt ] doWhileTrue: [ pkt isOfMaxLength	"indicates more packets to follow" ].

	"Gather data from all packets and return. Avoid another copy where possible"
	dataPackets size = 1 ifTrue: [ ^ dataPackets first data ].	"only one pcaket"
	(dataPackets size = 2 and: [ dataPackets last length = 0 ]) 
		ifTrue: [ ^ dataPackets first data ].	"second packet is empty"
	"Multiple packets; put the data together before returning"
	totalSize := dataPackets inject: 0 into: [:total :each | total + each length].
	buffer := ByteArray new: totalSize.
	ii := 1.
	^ dataPackets 
		inject: buffer
		into: [ :result :packet | 
			result replaceFrom: ii to: (ii + packet length - 1) with: packet data startingAt: 1.
			ii := ii + packet length.
			result]
]

{ #category : #'sequence numbering' }
GAMysqlNetSession >> resetSequence [
	nextPacketNumber := 0
]

{ #category : #accessing }
GAMysqlNetSession >> stream: aStream [
	theStream := aStream
	
]

{ #category : #accessing }
GAMysqlNetSession >> toHost: host andPort: port [ 
	| aStream |
	self resetSequence.
	[aStream := SocketStream 
		openConnectionToHostNamed: host
		port: port.
	"Turn off Nagle algorithm, else response time to short packets would suffer. Thanks to
	Goran Krampe for studying the issue in Ubuntu linux and figure out the details. Ref:
	http://developers.slashdot.org/comments.pl?sid=174457&threshold=1&commentsort=0&mode=thread&cid=14515105 for comments from John Nagle himself."
	aStream socket setOption: 'TCP_NODELAY' value: true.
	aStream binary. 
	self stream: aStream] 
		on: NameLookupFailure 
		do: [:ex | GAMysqlNameLookupFailure signal: ex messageText] 
]

{ #category : #'sequence numbering' }
GAMysqlNetSession >> updateSequence [
	nextPacketNumber := (nextPacketNumber + 1) bitAnd: 255
]

{ #category : #reading }
GAMysqlNetSession >> validatePacket: pkt [
	"Validate a network packet unit. Currently we validate the sequence number."
	"Update sequence if validation passes"
	(self validateSequence: pkt number)
		ifTrue: [self updateSequence]
		ifFalse: [^ self error: 'Packet sequence validation error']
	
]

{ #category : #'sequence numbering' }
GAMysqlNetSession >> validateSequence: pktNumber [ 
	^ pktNumber = nextPacketNumber
]

{ #category : #writing }
GAMysqlNetSession >> write: data [ 
	self writePacketData: data

]

{ #category : #writing }
GAMysqlNetSession >> writeNetPacket: pkt [
	"Write a network packet unit to the underlying stream".
	pkt writeTo: theStream
	
]

{ #category : #writing }
GAMysqlNetSession >> writePacketData: data [ 
	| pkt nextPktStart dataLen |
	
	nextPktStart := 1.
	dataLen := data size.
	[	pkt := GAMysqlNetPacket new.
		pkt length: (dataLen min: pkt maxLength);
			number: self getSequence;
			data: (data copyFrom: nextPktStart  to: (nextPktStart + pkt length - 1)).
			
		self updateSequence.
		dataLen := dataLen - pkt length.
		nextPktStart := nextPktStart + pkt length.
		
		self writeNetPacket: pkt
	] doWhileTrue: [ pkt isOfMaxLength ]
]
