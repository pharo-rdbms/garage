public
at: aColumn putNil: anObject
	"Goofy interface note - anObject is ignored here. When used by NBSQLite3Connection, anObject will always be nil."
	^ GASqlite3FFI current with: handle putNullAt: aColumn