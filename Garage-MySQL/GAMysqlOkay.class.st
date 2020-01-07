Class {
	#name : #GAMysqlOkay,
	#superclass : #GAMysqlResult,
	#instVars : [
		'message',
		'fieldCount',
		'affectedRows',
		'insertId',
		'warningCount',
		'serverStatus',
		'nextResult'
	],
	#category : 'Garage-MySQL-Protocol'
}

{ #category : #'as yet unclassified' }
GAMysqlOkay >> affectedRows [
	^ affectedRows 
]

{ #category : #accessing }
GAMysqlOkay >> generatedKey [
	
	^ insertId
]

{ #category : #'as yet unclassified' }
GAMysqlOkay >> hasMoreResults [
	^ (serverStatus bitAnd: GAMysqlServerStatusConstants moreResultsExist) ~= 0
	
]

{ #category : #'as yet unclassified' }
GAMysqlOkay >> inTransaction [
	| autoCommit inTx |
	autoCommit := (serverStatus bitAnd: GAMysqlServerStatusConstants statusInTransaction) ~= 0.
	inTx := (serverStatus bitAnd: GAMysqlServerStatusConstants statusInTransaction) ~= 0.
	^ autoCommit and: inTx
	
]

{ #category : #'as yet unclassified' }
GAMysqlOkay >> insertId [
	^ insertId 
]

{ #category : #'as yet unclassified' }
GAMysqlOkay >> isOkay [
	^ true
]

{ #category : #'as yet unclassified' }
GAMysqlOkay >> message [
	^ message 
]

{ #category : #'as yet unclassified' }
GAMysqlOkay >> nextResult [
	^ nextResult 
]

{ #category : #'as yet unclassified' }
GAMysqlOkay >> nextResult: aResult [
	nextResult := aResult 
	
]

{ #category : #'as yet unclassified' }
GAMysqlOkay >> parse [ 
	fieldCount := self decodeLcbFrom: inStream . "always 0"
	affectedRows := self decodeLcbFrom: inStream .
	insertId := self decodeLcbFrom: inStream .
	serverStatus := inStream next + (inStream next bitShift: 8) .
	warningCount := inStream next + (inStream next bitShift: 8) .
	message := (inStream upToEnd) asString.
	
]

{ #category : #'as yet unclassified' }
GAMysqlOkay >> serverStatus [
	^ serverStatus 
]

{ #category : #'as yet unclassified' }
GAMysqlOkay >> warningCount [
	^ warningCount 
]
