Class {
	#name : #GADataRow,
	#superclass : #Object,
	#type : #variable,
	#instVars : [
		'dictionary'
	],
	#category : 'Garage-Postgres-Driver'
}

{ #category : #'as yet unclassified' }
GADataRow class >> for: aDictionary [

	^(self new: aDictionary size)
		dictionary: aDictionary;
		yourself
]

{ #category : #'as yet unclassified' }
GADataRow >> atName: aSymbol [

	^self at: (dictionary at: aSymbol)
]

{ #category : #'as yet unclassified' }
GADataRow >> atName: aSymbol ifAbsent: aBlock [

	^self at: (dictionary 
		at: aSymbol
		ifAbsent: [ ^aBlock value ])
]

{ #category : #accessing }
GADataRow >> dictionary [
	
	^dictionary
]

{ #category : #'as yet unclassified' }
GADataRow >> dictionary: anIdentityDictionary [

	dictionary := anIdentityDictionary 
]

{ #category : #'as yet unclassified' }
GADataRow >> doesNotUnderstand: aMessage [

	^self at: (
		dictionary 
			at: aMessage selector
			ifAbsent: [ ^super doesNotUnderstand: aMessage ])
]

{ #category : #'as yet unclassified' }
GADataRow >> indexOf: aSymbol [

	^dictionary at: aSymbol ifAbsent: 0
]

{ #category : #'as yet unclassified' }
GADataRow >> name [

	^self atName: #name
]

{ #category : #'as yet unclassified' }
GADataRow >> printOn: aStream [

	super printOn: aStream.
	aStream nextPut: $(.
	(dictionary associations
		sort: [ :a :b | a value < b value ])
		do: [ :assoc |
			aStream 
				nextPutAll: assoc key;
				nextPutAll: ': ';
				print: (self at: assoc value) ]
		separatedBy: [ aStream nextPutAll: ', ' ].
	aStream nextPut: $)
]
