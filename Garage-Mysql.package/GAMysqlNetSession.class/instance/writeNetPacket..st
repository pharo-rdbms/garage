writing
writeNetPacket: pkt
	"Write a network packet unit to the underlying stream".
	pkt writeTo: theStream
	