converters
dateConverter 

	^[:s |
		Date
			year: (s copyFrom: 1 to: 4) asInteger
			month: (s copyFrom: 6 to: 7) asInteger
			day: (s copyFrom: 9 to: 10) asInteger ]
