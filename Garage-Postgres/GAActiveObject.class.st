Class {
	#name : #GAActiveObject,
	#superclass : #Object,
	#instVars : [
		'trace',
		'state',
		'events'
	],
	#classInstVars : [
		'stateTransitionTable'
	],
	#category : 'Garage-Postgres-Protocol'
}

{ #category : #stt }
GAActiveObject class >> buildStateTransitionTable [

	^IdentityDictionary new

]

{ #category : #stt }
GAActiveObject class >> resetStateTransitionTable [

	stateTransitionTable := nil

]

{ #category : #stt }
GAActiveObject class >> stateTransitionTable [

	stateTransitionTable == nil ifTrue: [stateTransitionTable := self buildStateTransitionTable].
	^ stateTransitionTable

]

{ #category : #'private-sa' }
GAActiveObject >> generateEvent: event to: receiver [

	^self == receiver
		ifTrue: [self processEvent: event]
		ifFalse: [receiver queueEvent: event].

]

{ #category : #'initialize/release' }
GAActiveObject >> initialize [

	state := #Created.
	events := OrderedCollection new.
	^self

]

{ #category : #trace }
GAActiveObject >> log: where text: text [

	self logInfo: where, ': ', text.

]

{ #category : #trace }
GAActiveObject >> logIdString [

	^ self class name, '(', self hash printString, ')'.

]

{ #category : #trace }
GAActiveObject >> logInfo: text [

	Transcript
		nextPut: $[;
		nextPutAll: self logIdString;
		nextPut: $];
		space;
		nextPutAll: text;
		cr;
		flush.

]

{ #category : #'private-sa' }
GAActiveObject >> nextEvent [

	^ #CantHappen

]

{ #category : #'private-sa' }
GAActiveObject >> processEvent: event [

	| nextState eventName eventNameString traceText |

	eventName := event isSymbol ifTrue: [event] ifFalse: [event eventName].
	nextState := (self stateTransitionTable at: state)
		at: eventName
		ifAbsent: [ #CantHappen ].

	trace >= 8 ifTrue: [
		eventNameString := event isSymbol ifTrue: [event asString] ifFalse: [event eventName].
		traceText := nextState = #EventIgnored
			ifTrue: [ state asString, ' IGNORE ', eventNameString ]
			ifFalse: [ state asString, '-->', nextState asString, ' on ', eventNameString ].
		self log: 'processEvent' text: traceText.
	].

	nextState = #EventIgnored
		ifFalse: [
			state := nextState.
			self perform: ('st', state asString, ':') asSymbol with: event.
		].

]

{ #category : #'private-sa' }
GAActiveObject >> queueEvent: event [

	events addLast: event.

]

{ #category : #'private-sa' }
GAActiveObject >> saProcessEventsUntil: newStates [

	[
		[events size > 0] whileTrue: [
			self processEvent: events removeFirst.
		].
		(newStates includes: state) 
			ifFalse: [self generateEvent: self nextEvent to: self].
		(newStates includes: state) not
	] whileTrue.

]

{ #category : #'private-sa' }
GAActiveObject >> stCantHappen: event [
	"Handle a defective state machine."

	self error: self class name, ' has a defective state machine'.

]

{ #category : #'private-sa' }
GAActiveObject >> stateTransitionTable [

	^ self class stateTransitionTable

]

{ #category : #trace }
GAActiveObject >> trace [
	^trace
]

{ #category : #trace }
GAActiveObject >> trace: anInteger [
	trace := anInteger
]
