as yet unclassified
encodeLcs: bytes on: aStream
	| len |
	len := bytes size .
	self encodeLcb: len on: aStream .
	aStream nextPutAll: bytes .
	