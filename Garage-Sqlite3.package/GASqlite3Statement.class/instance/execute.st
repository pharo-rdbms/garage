execute
execute
	prepared
		ifFalse: [ self prepare ].
	self reset.
	self
		basicExecute: [ :theStatement | 
			| generatedKey |
			generatedKey := GASqlite3FFI current
				lastInsertRowId: connection handle.
			fetchListener ifNotNil: #fetchOccurred.
			^ GASqlite3ResultSet new
				statement: theStatement;
				generatedKey: generatedKey;
				yourself ]