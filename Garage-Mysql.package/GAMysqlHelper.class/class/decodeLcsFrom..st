as yet unclassified
decodeLcsFrom: aStream 
	"parses length coded string"
	| len |
	len := self decodeLcbFrom: aStream.
	len = -1 ifTrue: [^ 'NULL'].
	^ aStream next: len.
	