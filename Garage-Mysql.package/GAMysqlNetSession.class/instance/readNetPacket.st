reading
readNetPacket
	| pkt |
	pkt := GAMysqlNetPacket new.
	pkt readFrom: theStream.
	self validatePacket: pkt.
	^ pkt