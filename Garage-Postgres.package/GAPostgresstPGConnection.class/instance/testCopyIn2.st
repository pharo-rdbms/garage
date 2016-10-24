tests
testCopyIn2

	| ws result conn |

	self dropTestCopyInOutTable.
	self createTestCopyInOutTable.

	ws := WriteStream on: String new.
	ws nextPutAll: (self makeCopyInOutLine: (Array with: '77' with: 'abcde')).
	ws nextPutAll: self makeCopyInOutEos.

	conn := self newConnection.
	conn startup.
	conn copy: 'copy TestCopyInOutTable from stdin' withStream: ws.
	result := conn execute: 'select * from TestCopyInOutTable'.
	conn terminate.
	self assert: result rows size = 1.
