setting up
setUp: someOptions

	"We create the connection that will create the database. The other one will be created lazily"
	options := someOptions.
	connection := setupConnection := nil.
	self createSetupConnection.
	self dropDatabase.
	self createDatabase.
	self createTables.