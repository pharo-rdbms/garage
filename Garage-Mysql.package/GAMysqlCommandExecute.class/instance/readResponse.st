as yet unclassified
readResponse
	| resp |
	resp := self readResult.
	"We do not need to look for multi-result responses in statement execute; so the following
	line of code is commented out. Check COM_QUERY response handling for multi-result"
	"resp hasMoreResults ifTrue: [resp next: self readResponse]."
	^ resp
	