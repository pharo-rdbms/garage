as yet unclassified
read: buffer
	discriminator := buffer first.
	inStream := ReadStream on: buffer.
	^ self parse