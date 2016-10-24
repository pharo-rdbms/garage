tests
testJsonFieldConverter
	| conn result data jsonObject |
	
	conn := self newConnection.
	conn startup.
	(self supportsJsonType: conn) ifFalse: [ 
		conn terminate.
		self skip].
	self dropJsonFieldConverterTable.
	self createJsonFieldConverterTable.
	jsonObject := self sampleJsonObject.

	result := conn execute: 'INSERT INTO jsonfieldconvertertable VALUES (' , (Json render: jsonObject) printString , ')'.
	result := conn execute: 'SELECT * from jsonfieldconvertertable'.
	conn terminate.
	self assert: result rows size = 1.
	data := result rows first data.	"result rows first inspect."
	self assert: (data at: 1) class = JsonObject.
	self assert: (data at: 1) = jsonObject.

	

	
	