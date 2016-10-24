factory
newPacket: typeCode
	| packetClass |

	packetClass := PacketClasses at: typeCode ifAbsent: [nil].
	^packetClass isNil
		ifTrue: [nil]
		ifFalse: [packetClass new]