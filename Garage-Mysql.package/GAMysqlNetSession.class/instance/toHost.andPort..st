accessing
toHost: host andPort: port 
	| aStream |
	self resetSequence.
	[aStream := SocketStream 
		openConnectionToHostNamed: host
		port: port.
	"Turn off Nagle algorithm, else response time to short packets would suffer. Thanks to
	Goran Krampe for studying the issue in Ubuntu linux and figure out the details. Ref:
	http://developers.slashdot.org/comments.pl?sid=174457&threshold=1&commentsort=0&mode=thread&cid=14515105 for comments from John Nagle himself."
	aStream socket setOption: 'TCP_NODELAY' value: true.
	aStream binary. 
	self stream: aStream] 
		on: NameLookupFailure 
		do: [:ex | GAMysqlNameLookupFailure signal: ex messageText] 