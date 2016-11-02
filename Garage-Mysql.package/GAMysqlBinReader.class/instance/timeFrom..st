time
timeFrom: aStream 
	"ByteStream"
	"length(1) + sign(1) + days(4) + hh(1) + mm(1) + ss(1) + subSeconds(4)"
	"According to the mySQL docs, it deos not store the fraction part of the seconds."
	| length sign days hh mm ss timeDuration timeOfDay ns |
	length := aStream next.
	length = 0 ifTrue: [ ^ Time midnight ].
	sign := aStream next = 0 
		ifTrue: [ 1 ]
		ifFalse: [ 1 negated ].
	days := self longIntFrom: aStream.
	hh := mm := ss := ns := 0.
	length > 5 ifTrue: 
		[ hh := self tinyIntFrom: aStream.
		mm := self tinyIntFrom: aStream.
		ss := self tinyIntFrom: aStream ].
	length > 8 ifTrue: [ ns := 1000 * (self longIntFrom: aStream) ].
	timeDuration := Duration 
		days: days
		hours: hh
		minutes: mm
		seconds: ss
		nanoSeconds: ns.
	timeOfDay := Time 
		hour: hh
		minute: mm
		second: ss
		nanoSecond: ns.
	sign < 0 ifTrue: [ ^ timeDuration negated ].
	days > 0 
		ifTrue: [ ^ timeDuration ]
		ifFalse: [ ^ timeOfDay ]