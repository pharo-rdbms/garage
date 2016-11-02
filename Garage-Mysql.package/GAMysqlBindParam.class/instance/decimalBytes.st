writes
decimalBytes
	"For scaled decimal"
	ByteArray streamContents: [:strm |
		strm nextPutAll: (paramValue abs printString allButLast:2) asByteArray.
		^ strm contents]
	