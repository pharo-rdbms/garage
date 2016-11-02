as yet unclassified
decodeLcbFrom: byteStream 
	"parse length coded binary"
	| first |
	first := byteStream next.
	(first 
		between: 0
		and: 250) ifTrue: [ ^ first ].
	first = 251 ifTrue: [ ^ -1 ].	"column value is NULL; applicable for row data packet only"
	first = 252 ifTrue: [ ^ byteStream next + (byteStream next bitShift: 8) ].	"value of following 2 bytes"
	first = 253 ifTrue: 
		[ ^ byteStream next + (byteStream next bitShift: 8) + (byteStream next bitShift: 16) ].	"value of following 3 bytes"
	first = 254 ifTrue: 
		[ ^ byteStream next + (byteStream next bitShift: 8 * 1) + (byteStream next bitShift: 8 * 2) + (byteStream next bitShift: 8 * 3) + (byteStream next bitShift: 8 * 4) + (byteStream next bitShift: 8 * 5) + (byteStream next bitShift: 8 * 6) + (byteStream next bitShift: 8 * 7) ].	"value of following 8 bytes"
	^ nil