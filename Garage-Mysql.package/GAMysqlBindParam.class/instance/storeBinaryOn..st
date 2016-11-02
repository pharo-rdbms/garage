accessing
storeBinaryOn: aStream		
	paramType 
	caseOf: {
		[GAMysqlTypes typeNULL]->[].
		[GAMysqlTypes typeTINY]->[aStream nextPutAll: (self integerBytes: 1)].
		[GAMysqlTypes typeSHORT]->[aStream nextPutAll: (self integerBytes: 2)].
		[GAMysqlTypes typeLONG]->[aStream nextPutAll: (self integerBytes: 4)].		
		[GAMysqlTypes typeLONGLONG]->[aStream nextPutAll: (self integerBytes: 8)].	
		[GAMysqlTypes typeFLOAT]->[aStream nextPutAll: (self floatBytes)].
		[GAMysqlTypes typeDOUBLE]->[aStream nextPutAll: (self doubleBytes)].
		[GAMysqlTypes typeTIME]->[aStream nextPutAll: self timeBytes].
		[GAMysqlTypes typeDATE]->[aStream nextPutAll: self dateTimeBytes].
		[GAMysqlTypes typeTIMESTAMP]->[aStream nextPutAll: self dateTimeBytes].
		[GAMysqlTypes typeDATETIME]->[aStream nextPutAll: self dateTimeBytes].	
		[GAMysqlTypes typeDECIMAL]->[aStream nextPutAll: self decimalBytes]	
	} 
	otherwise: [aStream nextPutAll: self stringOrBlobBytes]
	