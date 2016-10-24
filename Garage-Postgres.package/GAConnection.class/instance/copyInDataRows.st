private-actions
copyInDataRows
	"copyStream is initially positioned at the start of a data rows stream.
	The contents are sent down the socket.

	In a stream of data rows, each row is terminatated by a Byte1('\n').
	A sequence of Byte1('\\'), Byte1('.'), Byte1('\n') is the last line.
	"

	trace >= 8
		ifTrue: [ self log: 'copyInDataRows' text: copyStream contents printString ].

	socket sendData: copyStream contents.
	"socket sendData: (String with: $\ with: $. with: Character lf)."
