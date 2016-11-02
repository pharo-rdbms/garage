as yet unclassified
readRowData: fields 
	| respRows row |
	respRows := OrderedCollection new.
	[self gotEof] whileFalse: [ 
		"Read each field and save it"
		row := self readOneRow: fields.
		respRows add: row].
		
	^ respRows asArray
	