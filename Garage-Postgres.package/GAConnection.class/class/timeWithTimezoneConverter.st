converters
timeWithTimezoneConverter
 
	^[:s |
		| list |
		list := (s subStrings: ':') collect:[:i | i asInteger].
		Time fromSeconds: ((list at: 1) * 3600) + ((list at: 2) * 60) + (list at: 3) ]

