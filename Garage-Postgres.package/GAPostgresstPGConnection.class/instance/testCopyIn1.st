tests
testCopyIn1

	| ws conn result |
	ws := WriteStream on: String new.
	ws nextPutAll: self makeCopyInOutEos.

	self dropTestCopyInOutTable.
	self createTestCopyInOutTable.

	conn := self newConnection.
	conn startup.
	conn copy: 'copy TestCopyInOutTable from stdin' withStream: ws.
	result := conn execute: 'select * from TestCopyInOutTable'.
	conn terminate.

	self assert: result rows size = 0.
