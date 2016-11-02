parsing
parse
	| col row |
	inStream next.	"header: always 0"
	row := GAMysqlRow new.
	row columnDescriptors: columnDescriptors.
	
	nullBitMap := inStream next: (columnDescriptors size + 9) // 8.
	columnDescriptors doWithIndex: 
		[ :colDescr :indx | 
		col := (self isColumnNullAt: indx) 
			ifTrue: [ nil ]
			ifFalse: [ self 
					readColumnFrom: inStream
					perDescrption: colDescr ].
		row
			at: indx
			put: col ].
		
	^ row