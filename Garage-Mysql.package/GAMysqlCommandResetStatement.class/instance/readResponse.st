as yet unclassified
readResponse
	| pkt |

	pkt := super readResponse.
	pkt isOkayOrError 
		ifTrue: [^ pkt] 
		ifFalse: [self error: 'Unrecognized response for command']
		