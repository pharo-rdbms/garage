converters
floatConverter

	^[ :s | (Number readFrom: (ReadStream on: s)) asFloat ]