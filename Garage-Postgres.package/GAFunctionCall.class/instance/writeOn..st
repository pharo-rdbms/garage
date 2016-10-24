printing
writeOn: aStream

	self writeByte: $F on: aStream.
	self writeString: '' on: aStream.
	self writeInt32: self oid on: aStream.
	self writeInt32: self arguments size on: aStream.
	self arguments do: [:arg |
		self writeInt32: arg size on: aStream.
		arg do: [:b | self writeByte: (Character value: b) on: aStream].
	]