bindings
placeholderAt: anInteger 
	
	"Returns the placeholder that should correspond for a prepared statement at a given index.
	This method is meant to handle compatibility between databases that accept '?' like placeholders and others that accept '$1' like placeholders."
	^ '?'