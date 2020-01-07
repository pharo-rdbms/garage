Class {
	#name : #GANotificationResponse,
	#superclass : #GAPacket,
	#instVars : [
		'processId',
		'conditionName'
	],
	#category : 'Garage-Postgres-Protocol'
}

{ #category : #accessing }
GANotificationResponse >> conditionName [
	"Answer the value of conditionName"

	^ conditionName
]

{ #category : #accessing }
GANotificationResponse >> conditionName: anObject [
	"Set the value of conditionName"

	conditionName := anObject
]

{ #category : #accessing }
GANotificationResponse >> eventName [
	^#NotificationResponse
]

{ #category : #accessing }
GANotificationResponse >> processId [
	"Answer the value of processId"

	^ processId
]

{ #category : #accessing }
GANotificationResponse >> processId: anObject [
	"Set the value of processId"

	processId := anObject
]

{ #category : #receiving }
GANotificationResponse >> receiveFrom: connection [

	processId := self readInt32From: connection.
	conditionName := self readStringFrom: connection.

]
