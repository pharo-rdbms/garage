testing
supportsAutomaticQueryEncoding
	
	"Tests if the current database driver supports not-encoded strings inside a sql query.
	When true the driver will encode the full request into the configured encoding and the user does not have to manage it.
	When false the driver does not support encoding the query and thus the user has to encode manually arguments if building a query by String concatenation.
	
	Alternatively, use prepared statements when supported to avoid this issue"
	self subclassResponsibility