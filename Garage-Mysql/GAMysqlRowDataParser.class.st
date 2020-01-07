Class {
	#name : #GAMysqlRowDataParser,
	#superclass : #GAMysqlPacket,
	#instVars : [
		'driver',
		'columnDescriptors'
	],
	#category : 'Garage-MySQL-Protocol'
}

{ #category : #accessing }
GAMysqlRowDataParser >> columnDescriptors: aCollection [

	columnDescriptors := aCollection
]

{ #category : #accessing }
GAMysqlRowDataParser >> driver: aGAMysqlDriver [ 
	
	driver := aGAMysqlDriver
]

{ #category : #parsing }
GAMysqlRowDataParser >> parse [
	self subclassResponsibility 
	
]
