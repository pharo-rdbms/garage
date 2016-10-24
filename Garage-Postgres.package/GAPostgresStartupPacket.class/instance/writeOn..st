sending
writeOn: aStream

	self writeInt32: self byteCount on: aStream.
	self writeInt32: self version on: aStream.
	self writeLimString: self databaseName size: 64 on: aStream.
	self writeLimString: self userName size: 32 on: aStream.
	self writeLimString: self extraArgs size: 64 on: aStream.
	self writeLimString: nil size: 64 on: aStream. "unused"
	self writeLimString: self debugTty size: 64 on: aStream.
