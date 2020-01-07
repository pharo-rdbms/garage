Class {
	#name : #GAAsciiRow,
	#superclass : #GAPacket,
	#instVars : [
		'description',
		'nullFields',
		'rawData'
	],
	#category : 'Garage-Postgres-Driver'
}

{ #category : #'instance creation' }
GAAsciiRow class >> description: aRowDescription [

	^self new
		description: aRowDescription;
		yourself.

]

{ #category : #'instance creation' }
GAAsciiRow class >> new [

	^self basicNew initialize.

]

{ #category : #converting }
GAAsciiRow >> asArray [

	^ self data asArray
]

{ #category : #accessing }
GAAsciiRow >> at: index [

	^ self data at: index
]

{ #category : #accessing }
GAAsciiRow >> atIndex: anInteger [ 
	
	^ self data at: anInteger
]

{ #category : #accessing }
GAAsciiRow >> atName: aString [ 
	
	^ self atIndex: (self indexOfColumnName: aString)
]

{ #category : #accessing }
GAAsciiRow >> data [

	| converters converter data |

	converters := description resultSet result connection fieldConverters.
	data := OrderedCollection new.
	rawData with: description columnDescriptions do: [:each :aColumnDescription |
		data addLast: (
			each isNil
				ifTrue: [nil]
				ifFalse: [
					converter := converters at: aColumnDescription typeOid ifAbsent: [nil].
					converter isNil ifTrue: [ each ] ifFalse: [ converter value: each ].
				]).
	].
	^data

]

{ #category : #accessing }
GAAsciiRow >> dataKeyedByFieldName [

	| d |

	d := Dictionary new.
	self data with: description columnDescriptions do: [:each :aColumnDescription |
		d at: aColumnDescription fieldName put: each.
	].
	^ d

]

{ #category : #accessing }
GAAsciiRow >> dataRow [

	| converters converter data dictionary index |

	converters := description resultSet result connection fieldConverters.
	dictionary := description columnDescriptionDictionary.
	data := GADataRow for: dictionary.
	index := 0.
	rawData with: description columnDescriptions do: [ :each :aColumnDescription |
		data
			at: (index := index + 1)
			put: (
				each ifNotNil: [
					(converter := converters at: aColumnDescription typeOid ifAbsent: nil)
						ifNil: [ each ]
						ifNotNil: [ converter reentrant value: each ] ]) ].
	^data

]

{ #category : #accessing }
GAAsciiRow >> description: aRowDescription [
	description := aRowDescription.

]

{ #category : #printing }
GAAsciiRow >> displayOn: aStream [

	rawData withIndexDo: [:each :i |
		aStream nextPutAll: (each == nil ifTrue: ['0'] ifFalse: [each]).
		i < rawData size ifTrue: [aStream space].
	].

]

{ #category : #enumerating }
GAAsciiRow >> do: aBlockClosure [ 
	self data do: aBlockClosure
]

{ #category : #'reflective operations' }
GAAsciiRow >> doesNotUnderstand: aMessage [
	^ aMessage sendTo: self data 
]

{ #category : #accessing }
GAAsciiRow >> eventName [
	^#AsciiRow
]

{ #category : #accessing }
GAAsciiRow >> first [

	^ self data first
]

{ #category : #accessing }
GAAsciiRow >> indexOfColumnName: aString [ 
	
	^ description columnDescriptionDictionary at: aString asSymbol
]

{ #category : #initialization }
GAAsciiRow >> initialize [

	rawData := OrderedCollection new.
	^self
]

{ #category : #accessing }
GAAsciiRow >> last [

	^ self data last
]

{ #category : #printing }
GAAsciiRow >> printOn: aStream [

	super printOn: aStream.
	aStream nextPutAll: '('.
	rawData do: [:each | each printOn: aStream. aStream nextPut: $,].
	aStream skip: -1; nextPutAll: ')'.

]

{ #category : #accessing }
GAAsciiRow >> rawData [
	^ rawData
]

{ #category : #receiving }
GAAsciiRow >> receiveFrom: connection [

	| ncol |

	description := connection result rowDescription.
	ncol := description numberOfColumns.
	nullFields := self readBitmap: ncol from: connection.
	0 to: ncol - 1 do: [:i |
		((nullFields at: (i // 8) + 1) bitAnd: (2r10000000 bitShift: (i \\ 8) negated)) > 0
			ifTrue: [rawData add: (self readFieldFrom: connection)]
			ifFalse: [rawData add: nil].
	].

]

{ #category : #accessing }
GAAsciiRow >> size [

	^ self data size
]
