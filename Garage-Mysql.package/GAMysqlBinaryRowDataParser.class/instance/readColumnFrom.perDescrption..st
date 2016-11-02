parsing
readColumnFrom: aStream perDescrption: columnDescr
	| reader value mask |

	reader := GAMysqlBinReader default.
	value := columnDescr type 
		caseOf: {
		[GAMysqlTypes typeTINY]->[mask := 16r80. reader tinyIntFrom: aStream].
		[GAMysqlTypes typeSHORT]->[mask := 16r8000. reader smallIntFrom: aStream].
		[GAMysqlTypes typeINT24]->[mask := 16r80000000. reader mediumIntFrom: aStream].	
		[GAMysqlTypes typeLONG]->[mask := 16r80000000. reader longIntFrom: aStream].	
		[GAMysqlTypes typeLONGLONG]->[
			mask := 16r8000000000000000. 
			reader bigIntFrom: aStream].

		[GAMysqlTypes typeFLOAT]->[reader floatFrom: aStream].
		[GAMysqlTypes typeDOUBLE]->[reader doubleFrom: aStream].
		[GAMysqlTypes typeDECIMAL]->[reader decimalWithScale: columnDescr decimals from: aStream].
		[GAMysqlTypes typeNEWDECIMAL]->[reader decimalWithScale: columnDescr decimals from: aStream].
	
		[GAMysqlTypes typeSTRING]->[ (driver encoder decodeBytes: (reader varBlobFrom: aStream)) ].
		[GAMysqlTypes typeVARCHAR]->[ (driver encoder decodeBytes: (reader varBlobFrom: aStream)) ].
		[GAMysqlTypes typeVARSTRING]->[ (driver encoder decodeBytes: (reader varBlobFrom: aStream)) ].
	
		[GAMysqlTypes typeTIME]->[reader timeFrom: aStream].
		[GAMysqlTypes typeDATE]->[reader dateFrom: aStream].
		[GAMysqlTypes typeDATETIME]->[reader dateTimeFrom: aStream].
		[GAMysqlTypes typeTIMESTAMP]->[reader timeStampFrom: aStream].
		[GAMysqlTypes typeYEAR]->[reader yearFrom: aStream].
		[GAMysqlTypes typeNEWDATE]->[reader shouldBeImplemented].
	
		[GAMysqlTypes typeTINYBLOB]->[reader varBlobFrom: aStream].
		[GAMysqlTypes typeBLOB]->[reader varBlobFrom: aStream].
		[GAMysqlTypes typeMEDIUMBLOB]->[reader varBlobFrom: aStream].
		[GAMysqlTypes typeLONGBLOB]->[reader varBlobFrom: aStream].
		
		[GAMysqlTypes typeNULL]->[self shouldBeImplemented].
	
		[GAMysqlTypes typeGEOMETRY]->[self shouldBeImplemented].
		[GAMysqlTypes typeSET]->[self shouldBeImplemented].
		[GAMysqlTypes typeENUM]->[self shouldBeImplemented].
		[GAMysqlTypes typeBIT]->[self shouldBeImplemented].
		} 
		otherwise: [^ self error: 'Unknown mysql type'].
		
	(value isInteger and: [columnDescr isUnsigned not and: [(value bitAnd: mask) ~= 0]]) 
	  ifTrue: [
		value  := value - (mask << 1) "if msb is set and field is signed, then negative"].
	^ value
	