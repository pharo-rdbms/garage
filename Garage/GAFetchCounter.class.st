Class {
	#name : #GAFetchCounter,
	#superclass : #Object,
	#instVars : [
		'fetches'
	],
	#category : 'Garage-Tests'
}

{ #category : #events }
GAFetchCounter >> fetchOccurred [
	
	fetches := fetches + 1
]

{ #category : #accessing }
GAFetchCounter >> fetches [
	
	^ fetches
]

{ #category : #accessing }
GAFetchCounter >> initialize [

	super initialize.
	fetches := 0
]
