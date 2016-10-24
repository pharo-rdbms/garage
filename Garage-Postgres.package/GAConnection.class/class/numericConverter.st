converters
numericConverter
	"This should convert the value to ScaledDecimal"

	^[ :s | (Number readFrom: (ReadStream on: s)) asFloat ]