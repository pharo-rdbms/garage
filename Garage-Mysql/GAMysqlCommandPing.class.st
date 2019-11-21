Class {
	#name : #GAMysqlCommandPing,
	#superclass : #GAMysqlCommandBase,
	#category : 'Garage-Mysql-Protocol'
}

{ #category : #'as yet unclassified' }
GAMysqlCommandPing >> commandArg [
	^ nil
]

{ #category : #'as yet unclassified' }
GAMysqlCommandPing >> commandCode [
	^ ComPing 
]

{ #category : #'as yet unclassified' }
GAMysqlCommandPing >> readResponse [
	| pkt |

	pkt := super readResponse.
	pkt isOkayOrError 
		ifTrue: [^ pkt] 
		ifFalse: [self error: 'Unrecognized response for command']
		
]
