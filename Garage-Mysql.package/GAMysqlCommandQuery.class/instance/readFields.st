as yet unclassified
readFields
	| respFields field |
	respFields := OrderedCollection new.
	
	[self gotEof] whileFalse:[ 
		"Read each field and save it"
		field := self readOneField.
		respFields add: field ].
		
	^ respFields asArray
	