writes
stringOrBlobBytes		
	ByteArray streamContents: [:strm |
		GAMysqlHelper encodeLcs: self stringOrBlobBytesRaw on: strm.
		^ strm contents]
	