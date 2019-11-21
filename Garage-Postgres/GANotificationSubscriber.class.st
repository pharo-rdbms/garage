Class {
	#name : #GANotificationSubscriber,
	#superclass : #GAActiveObject,
	#category : 'Garage-Postgres-Protocol'
}

{ #category : #api }
GANotificationSubscriber >> receive: notice from: aConnection [

	self logInfo: notice printString, ' received from ', aConnection logIdString.

]
