Class {
	#name : #GAMysqlTextRowDataParser,
	#superclass : #GAMysqlRowDataParser,
	#category : 'Garage-MySQL-Protocol'
}

{ #category : #preparing }
GAMysqlTextRowDataParser >> parse [
	|indx value row |

	row := GAMysqlRow new.
	row columnDescriptors: columnDescriptors.
	indx := 1.
	[inStream atEnd] whileFalse: [
		value := (self decodeLcsFrom: inStream) asString.
		value := self parseColumnValue: value byDescription: (columnDescriptors at: indx).
		row at: indx put: value.
		indx := indx + 1].
	^ row
]

{ #category : #parsing }
GAMysqlTextRowDataParser >> parseColumnValue: aString byDescription: columnDescr [
	
	| reader value |
	reader := nil.
	aString = 'NULL' ifTrue: [ ^ nil ].
	value := columnDescr type
		caseOf: {
		[GAMysqlTypes typeTINY]->[ aString asNumber ].
		[GAMysqlTypes typeSHORT]->[ aString asNumber ].
		[GAMysqlTypes typeINT24]->[ aString asNumber ].
		[GAMysqlTypes typeLONG]->[ aString asNumber ].
		[GAMysqlTypes typeLONGLONG]->[ aString asNumber ].

		[GAMysqlTypes typeFLOAT]->[ aString asNumber ].
		[GAMysqlTypes typeDOUBLE]->[ aString asNumber ].
		[GAMysqlTypes typeDECIMAL]->[ aString asNumber ].
		[GAMysqlTypes typeNEWDECIMAL]->[ aString asNumber ].
	
		[GAMysqlTypes typeSTRING]->[ driver encoder decodeBytes: aString asByteArray ].
		[GAMysqlTypes typeVARCHAR]->[ driver encoder decodeBytes: aString asByteArray ].
		[GAMysqlTypes typeVARSTRING]->[ driver encoder decodeBytes: aString asByteArray ].
	
		[GAMysqlTypes typeTIME]->[ Time fromString: aString].
		[GAMysqlTypes typeDATE]->[ Date fromString: aString].
		[GAMysqlTypes typeDATETIME]->[ DateAndTime fromString: aString ].
		[GAMysqlTypes typeTIMESTAMP]->[ DateAndTime fromString: aString ].
		[GAMysqlTypes typeYEAR]->[ aString asNumber ].
		[GAMysqlTypes typeNEWDATE]->[ Date fromString: aString ].
	
		[GAMysqlTypes typeTINYBLOB]->[ aString asByteArray ].
		[GAMysqlTypes typeBLOB]->[ aString asByteArray ].
		[GAMysqlTypes typeMEDIUMBLOB]->[ aString asByteArray ].
		[GAMysqlTypes typeLONGBLOB]->[ aString asByteArray ].
		
		[GAMysqlTypes typeNULL]->[ nil ].
	
		[GAMysqlTypes typeGEOMETRY]->[self shouldBeImplemented].
		[GAMysqlTypes typeSET]->[self shouldBeImplemented].
		[GAMysqlTypes typeENUM]->[self shouldBeImplemented].
		[GAMysqlTypes typeBIT]->[self shouldBeImplemented].
	} 
	otherwise: [^ self error: 'Unknown mysql type'].
	^ value
]
