reading
readPacketData
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