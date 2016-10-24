tests
supportsJsonType: conn
	
	^(conn execute: 'SELECT oid,typname from pg_type  WHERE oid = 114') rows size > 0
	
	