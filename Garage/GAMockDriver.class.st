Class {
	#name : #GAMockDriver,
	#superclass : #Object,
	#instVars : [
		'id'
	],
	#category : 'Garage-Tests'
}

{ #category : #'instance-creation' }
GAMockDriver class >> withId: aString [ 
	
	^ self new id: aString; yourself
]

{ #category : #accessing }
GAMockDriver >> driverId [
	
	^ id
]

{ #category : #accessing }
GAMockDriver >> id: aString [ 
	
	id := aString
]

{ #category : #accessing }
GAMockDriver >> initialize [
	super initialize.
	id := 'id'.
]
