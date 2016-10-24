sending
writeOn: aStream

	"Add 5 for the 32bit size header, and add 1 for the '\0' after the string"

	self writeInt32: self password size + 5 on: aStream.
	self writeString: self password on: aStream.
