accessing
detectParamType
	"Corresponding database type needs to be inferred from the bound value"
	paramValue ifNil: [ ^ GAMysqlTypes typeNULL ].

	(paramValue isKindOf: Boolean) ifTrue: [ ^ GAMysqlTypes typeTINY ].

	(paramValue isKindOf: Integer) ifTrue: [
		(self tinyIntRange includes: paramValue) ifTrue: [^ GAMysqlTypes typeTINY].
		(self smallIntRange includes: paramValue) ifTrue: [^ GAMysqlTypes typeSHORT].
		(self longIntRange includes: paramValue) ifTrue: [^ GAMysqlTypes typeLONG].
		(self bigIntRange includes: paramValue) ifTrue: [^ GAMysqlTypes typeLONGLONG].
		^ GAMysqlBindError signal: 'Supplied integer does not have a matching database type'].

	(paramValue isKindOf: ScaledDecimal) ifTrue: [ ^ GAMysqlTypes typeDECIMAL ].
	((paramValue isKindOf: Float) or:  [paramValue isKindOf: Fraction]) 
		ifTrue: [	
			(paramValue asFloat at: 2) = 0 
				ifTrue: [^ GAMysqlTypes typeFLOAT]
				ifFalse: [^ GAMysqlTypes typeDOUBLE] ].

	(paramValue isKindOf: Character) ifTrue: [ ^ GAMysqlTypes typeSTRING ].
	((paramValue isKindOf: String) or: [paramValue isKindOf: Text]) 
		ifTrue: [ ^ GAMysqlTypes typeVARSTRING ].

	(paramValue isMemberOf: DateAndTime) ifTrue: [ ^ GAMysqlTypes typeDATETIME ].
	(paramValue isKindOf: TimeStamp) ifTrue: [ ^ GAMysqlTypes typeTIMESTAMP ].
	((paramValue isKindOf: Time) or: [paramValue isKindOf: Duration]) 
		ifTrue: [ ^ GAMysqlTypes typeTIME ].
	(paramValue isKindOf: Date) ifTrue: [ ^ GAMysqlTypes typeDATE ].

	(paramValue isKindOf: ByteArray) ifTrue: [ 
		paramValue size < 16r100 ifTrue: [ ^ GAMysqlTypes typeTINYBLOB ].
		paramValue size < 16r10000 ifTrue: [ ^ GAMysqlTypes typeBLOB ].
		paramValue size < 16r1000000 ifTrue: [ ^ GAMysqlTypes typeMEDIUMBLOB ].
		^ GAMysqlTypes typeLONGBLOB ].
	
	^ GAMysqlBindError signal: 'Unsupported data type for param binding'
	