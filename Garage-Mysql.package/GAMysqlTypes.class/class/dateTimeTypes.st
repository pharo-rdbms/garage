as yet unclassified
dateTimeTypes
	dateTimeTypes ifNil: [
		dateTimeTypes := Array 
			with: TypeDATE with: TypeDATETIME with: TypeNEWDATE with: TypeTIME
			with: TypeTIMESTAMP with: TypeYEAR
		].
	^ dateTimeTypes
	