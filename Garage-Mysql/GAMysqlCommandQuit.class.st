Class {
	#name : #GAMysqlCommandQuit,
	#superclass : #GAMysqlCommandBase,
	#category : 'Garage-Mysql-Protocol'
}

{ #category : #'as yet unclassified' }
GAMysqlCommandQuit >> commandArg [
	^ nil
]

{ #category : #'as yet unclassified' }
GAMysqlCommandQuit >> commandCode [
	^ ComQuit 
]

{ #category : #'as yet unclassified' }
GAMysqlCommandQuit >> readResponse [
	^ nil
		
]
