Class {
	#name : #GANoticeResponse,
	#superclass : #GAAbstractStringResponse,
	#category : 'Garage-Postgres-Protocol'
}

{ #category : #accessing }
GANoticeResponse >> eventName [
	^#NoticeResponse
]
