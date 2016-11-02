execute
readResponse
	| pkt |

	pkt := super readResponse.
	pkt isOkayOrError 
		ifTrue: [^ pkt].
		
	pkt isEof ifTrue: [
		"Absorb the response"
		session read.
		"For old (short) hash style passwords"
		self send323Scramble.
		pkt := super readResponse.
		pkt isOkayOrError 
			ifTrue: [^ pkt]].
		
	GAMysqlDriverError signal: 'Unrecognized response for command'
	