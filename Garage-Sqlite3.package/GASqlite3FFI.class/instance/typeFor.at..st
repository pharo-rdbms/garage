public API
typeFor: aStatement at: aColumn
	^ DataTypeMap at: (self apiColumnType: aStatement atColumn: aColumn)
