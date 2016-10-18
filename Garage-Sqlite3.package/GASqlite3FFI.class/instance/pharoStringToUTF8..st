private - conversion
pharoStringToUTF8: aPharoString
	"Converts from Pharo Multibyte Characters to SQLite3 UTF-8 storage format"
	
	^ZnUTF8Encoder new encodeString: aPharoString