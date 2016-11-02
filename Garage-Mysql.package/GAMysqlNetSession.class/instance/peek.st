reading
peek
	"Look ahead; don't remove the packet until next read"
	peekData ifNil: [peekData := self readPacketData].
	^ peekData