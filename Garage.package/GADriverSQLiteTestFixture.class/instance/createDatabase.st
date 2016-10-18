as yet unclassified
createDatabase

	"Nothing"
	| encoding |	
	encoding := self connection encoding = 'utf8' ifTrue: [ 'UTF-8' ] ifFalse: ['UTF-16' ].
	self connection execute: 'PRAGMA encoding = "',encoding,'"'.