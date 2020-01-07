Class {
	#name : #GAMysqlResultSetHeader,
	#superclass : #GAMysqlPacket,
	#instVars : [
		'fieldCount',
		'extra'
	],
	#category : 'Garage-MySQL-Protocol'
}

{ #category : #'as yet unclassified' }
GAMysqlResultSetHeader >> fieldCount [
	^ fieldCount 
]

{ #category : #'as yet unclassified' }
GAMysqlResultSetHeader >> parse [
	fieldCount := self decodeLcbFrom: inStream.
	"exrta field may appear for some results (like show column)"
	inStream atEnd ifFalse: [extra := self decodeLcbFrom: inStream]
	
]
