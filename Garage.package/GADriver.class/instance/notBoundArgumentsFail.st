testing
notBoundArgumentsFail
	
	"Tests if the current database driver fails if a prepared statement contains arguments that are not bound. Some drivers such as Sqlite3 will default unbound arguments to NULL and not fail."
	^ true