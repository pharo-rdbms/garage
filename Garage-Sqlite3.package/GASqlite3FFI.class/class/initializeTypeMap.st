class initialization
initializeTypeMap

	TypeMap := Dictionary newFromPairs: #(
		sqlite3		      GASQLite3DatabaseExternalObject
		sqlite3_stmt			GASQLite3StatementExternalObject
		sqlite_int64			NBInt64
	)