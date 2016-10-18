bindings
at: aColumn bind: anObject

	"Binds a column at a particular index with an object. Objects are automatically transformed by the driver into the corresponding 	database representation."
	self subclassResponsibility