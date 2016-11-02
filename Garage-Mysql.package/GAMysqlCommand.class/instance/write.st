as yet unclassified
write
	| buffStream |
	buffStream := WriteStream on: ByteArray new.
	buffStream nextPut: command.
	arg isEmptyOrNil ifFalse: [ buffStream nextPutAll: arg asByteArray ].
	^ buffStream contents