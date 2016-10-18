statement
prepare: aQuery

	"Creates a statement object from a sql query and sends it for its preparation to the database server"
	self subclassResponsibility