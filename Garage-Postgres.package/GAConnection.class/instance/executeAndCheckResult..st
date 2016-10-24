api
executeAndCheckResult: sqlString
	"Same as execute: but check response - throw exception if error in response" 
	| res |
	res := self execute: sqlString.
	res isError ifTrue: [ GAError signal: res errorResponse value ].
	^ res.
