Class {
	#name : #GAPostgresRowDescription,
	#superclass : #GAPacket,
	#instVars : [
		'resultSet',
		'numberOfColumns',
		'columnDescriptions',
		'columnDescriptionDictionary'
	],
	#category : 'Garage-Postgres-Protocol'
}

{ #category : #'instance creation' }
GAPostgresRowDescription class >> new [

	^self basicNew initialize.

]

{ #category : #'as yet unclassified' }
GAPostgresRowDescription >> columnDescriptionDictionary [

	^columnDescriptionDictionary ifNil: [
		columnDescriptionDictionary := IdentityDictionary new.
		columnDescriptions doWithIndex: [ :each :i |
			columnDescriptionDictionary at: each fieldName asSymbol put: i ].
		columnDescriptionDictionary ]
]

{ #category : #accessing }
GAPostgresRowDescription >> columnDescriptions [
	^ columnDescriptions
]

{ #category : #printing }
GAPostgresRowDescription >> displayOn: aStream [

	columnDescriptions withIndexDo: [:each :i |
		each displayOn: aStream.
		i < columnDescriptions size ifTrue: [aStream space].
	].

]

{ #category : #accessing }
GAPostgresRowDescription >> eventName [
	^#RowDescription
]

{ #category : #initialize }
GAPostgresRowDescription >> initialize [

	numberOfColumns := 0.
	columnDescriptions := OrderedCollection new.

]

{ #category : #accessing }
GAPostgresRowDescription >> numberOfColumns [
	^numberOfColumns
]

{ #category : #printing }
GAPostgresRowDescription >> printOn: aStream [

	super printOn: aStream.
	aStream nextPutAll: '('; cr.
	columnDescriptions do: [:each | each printOn: aStream. aStream cr].
	aStream nextPutAll: ')'.

]

{ #category : #receiving }
GAPostgresRowDescription >> receiveFrom: connection [

	numberOfColumns := self readInt16From: connection.
	1 to: numberOfColumns do: [:i |
		columnDescriptions add: (GAColumnDescription new receiveFrom: connection; yourself).
	].

]

{ #category : #accessing }
GAPostgresRowDescription >> resultSet [
	^ resultSet
]

{ #category : #accessing }
GAPostgresRowDescription >> resultSet: anObject [
	resultSet := anObject
]
