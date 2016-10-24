accessing
fieldConverterAt: typeOid
	^ fieldConverters at: typeOid ifAbsent: [nil]
