sending
writeOn: aStream

	self writeByte: $Q on: aStream.
	self writeString: self queryString on: aStream.
