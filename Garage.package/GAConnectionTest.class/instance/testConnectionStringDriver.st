as yet unclassified
testConnectionStringDriver

	| driver |
	"Test that we can create a driver from a connection string such as
		opendbx:///Users/guillermopolito/work/temp/garage/memory?backend=sqlite3
	or
		 mysql:/localhost:3306/sodbxtest?user=sodbxtest&password=sodbxtest
	"
	driver := GADriver fromConnectionString: fixture connectionString.

	self assert: driver driverId asLowercase equals: fixture connectionString asZnUrl scheme asLowercase.