sending
writeOn: aStream
	"Write a cancel request on the stream."

	"80877102 - The cancel request code.
	The value is chosen to contain 1234 in the most significant 16 bits,
	and 5678 in the least 16 significant bits. (To avoid confusion,
	this code must not be the same as any protocol version number.)
	"

	self writeInt32: 16 on: aStream.
	self writeInt32: 80877102 on: aStream. "major=1234, minor=5678"
	self writeInt32: self processId on: aStream.
	self writeInt32: self secretKey on: aStream.
