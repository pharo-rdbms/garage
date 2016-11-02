accessing
atName: aString 
	
	^ columnValues
		at: ((columnDescriptors collect: #name) indexOf: aString asString)
		ifAbsent: [GAMysqlInvalidRowAccess signal: 'No data at name: ', aString asString]