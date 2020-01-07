Class {
	#name : #GAMysqlPrepareOkay,
	#superclass : #GAMysqlPacket,
	#instVars : [
		'warningCount',
		'numColumns',
		'numParams',
		'stmtId'
	],
	#category : 'Garage-MySQL-Protocol'
}

{ #category : #'as yet unclassified' }
GAMysqlPrepareOkay >> isOkay [
	^ true
	
]

{ #category : #'as yet unclassified' }
GAMysqlPrepareOkay >> numColumns [
	^ numColumns
]

{ #category : #'as yet unclassified' }
GAMysqlPrepareOkay >> numParams [
	^ numParams
]

{ #category : #'as yet unclassified' }
GAMysqlPrepareOkay >> parse [ 
	inStream next.	"always 0, marker for oaky pakcet"
	stmtId := inStream next + (inStream next bitShift: 8) + 
			(inStream next bitShift: 16) + (inStream next bitShift: 24).
	numColumns := inStream next + (inStream next bitShift: 8).
	numParams := inStream next + (inStream next bitShift: 8).
	inStream next.	"filler, always 0"
	warningCount := inStream next + (inStream next bitShift: 8)
	
]

{ #category : #'as yet unclassified' }
GAMysqlPrepareOkay >> stmtHandlerId [
	^ stmtId
]

{ #category : #'as yet unclassified' }
GAMysqlPrepareOkay >> warningCount [
	^ warningCount
	
]
