Class {
	#name : #GAFunctionResultResponse,
	#superclass : #GAPacket,
	#instVars : [
		'result'
	],
	#category : 'Garage-Postgres-Protocol'
}

{ #category : #accessing }
GAFunctionResultResponse >> eventName [
	^#FunctionResultResponse
]

{ #category : #printing }
GAFunctionResultResponse >> printOn: aStream [

	super printOn: aStream.
	aStream
		nextPutAll: '(';
		nextPutAll: 'result='; nextPutAll: result printString;
		nextPutAll: ')'
]

{ #category : #receiving }
GAFunctionResultResponse >> receiveFrom: connection [

	| emptyFlag resultSize |
	emptyFlag := connection next codePoint.
	emptyFlag == 71  "$G codePoint == 71 indicates non-void response"
		ifTrue: [
			resultSize := self readInt32From: connection.
			result := ByteArray new: resultSize.
			1 to: resultSize do: [:i | result at: i put: connection next codePoint].
			connection next. "toss the extra 0 byte"
	].

]

{ #category : #accessing }
GAFunctionResultResponse >> result [

	^result
]
