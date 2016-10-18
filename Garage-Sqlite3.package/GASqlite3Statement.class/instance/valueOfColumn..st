public
valueOfColumn: aColumn
	^ self perform: (self typeOfColumn: aColumn) with: aColumn
