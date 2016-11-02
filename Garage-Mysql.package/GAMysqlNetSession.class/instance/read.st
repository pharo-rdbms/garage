reading
read
	| data |
	"Return packet from look ahead buffer if any. Clear look ahead buffer"
	peekData ifNotNil: [data := peekData. peekData := nil. ^ data].
	^ self readPacketData
	