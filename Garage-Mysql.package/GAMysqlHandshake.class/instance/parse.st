as yet unclassified
parse 
	protocolVer := inStream next.
	serverVer := (inStream upTo: 0) asString.
	threadId := inStream next + (inStream next bitShift: 8) + 
		(inStream next bitShift: 16) + (inStream next bitShift: 24).
	scrambleBuff := inStream next: 8.
	inStream skip: 1.	"always 0"
	serverCap := inStream next + (inStream next bitShift: 8).
	serverLang := inStream next.
	serverStatus := inStream next + (inStream next bitShift: 8).
	inStream skip: 13.	"filler"
	self supportsProtocol41 ifFalse: [ ^ self ].
	scrambleBuffMore := inStream next: 12.
	inStream skip: 1	"always 0"
