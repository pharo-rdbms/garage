initialize/release
initialize

	| readBufferSize |

	super initialize.

	trace := self class defaultTraceLevel.
	readBufferSize := 8096.
	readBuffer := String new: readBufferSize.
	readIndex := readBufferSize + 1.
	lastReadIndex := readBufferSize.

	self fieldConverters: self class buildDefaultFieldConverters.
	result := GAResult on: self.

	sqlStringConverter := [:sqlString| sqlString].
	"^ self"
