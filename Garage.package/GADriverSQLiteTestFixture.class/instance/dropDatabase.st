as yet unclassified
dropDatabase

	"We remove the database file"
	self connection isMemory ifFalse: [ self connection database asFileReference delete ].