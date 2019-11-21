Class {
	#name : #GAMysqlPrepareResponse,
	#superclass : #GAMysqlResult,
	#instVars : [
		'prepareOkay',
		'paramDescriptors',
		'paramEof',
		'columnDescriptors',
		'columnEof'
	],
	#category : 'Garage-Mysql-Protocol'
}

{ #category : #'as yet unclassified' }
GAMysqlPrepareResponse >> columnDescriptors [
	^ columnDescriptors
	
]

{ #category : #'as yet unclassified' }
GAMysqlPrepareResponse >> columnDescriptors: fields [
	columnDescriptors := fields 
	
]

{ #category : #'as yet unclassified' }
GAMysqlPrepareResponse >> columnEof: anEof [
	columnEof := anEof
	
]

{ #category : #'as yet unclassified' }
GAMysqlPrepareResponse >> isOkay [
	^ prepareOkay isOkay 
	
]

{ #category : #'as yet unclassified' }
GAMysqlPrepareResponse >> isPrepareResponse [
	^ true
	
]

{ #category : #'as yet unclassified' }
GAMysqlPrepareResponse >> paramDescriptors [
	^ paramDescriptors
	 
	
]

{ #category : #'as yet unclassified' }
GAMysqlPrepareResponse >> paramDescriptors: fields [
	paramDescriptors := fields 
	
]

{ #category : #'as yet unclassified' }
GAMysqlPrepareResponse >> paramEof: anEof [
	paramEof := anEof 
	
]

{ #category : #'as yet unclassified' }
GAMysqlPrepareResponse >> prepareOkay [
	^ prepareOkay
	
]

{ #category : #'as yet unclassified' }
GAMysqlPrepareResponse >> prepareOkay: prepOkay [
	prepareOkay := prepOkay
	
]
