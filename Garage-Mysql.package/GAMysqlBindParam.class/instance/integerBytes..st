writes
integerBytes: size 
	| storable |
	ByteArray streamContents: [:strm |
		storable := self storableIntegerValueOfSize: size.
		1 to: size do: [:ii | strm nextPut: (storable digitAt: ii)].
		^ strm contents]
	