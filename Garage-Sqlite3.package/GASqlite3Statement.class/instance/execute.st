execute
execute
	
	prepared ifFalse: [ self prepare ].
	
	self reset.
	self basicExecute: [ :theStatement | | generatedKey |
		generatedKey := GASqlite3FFI current lastInsertRowId: connection handle.
		fetchListener ifNotNilDo: #fetchOccurred.
		^ GASqlite3ResultSet new
			statement: theStatement;
			generatedKey: generatedKey;
			yourself.
		 ]