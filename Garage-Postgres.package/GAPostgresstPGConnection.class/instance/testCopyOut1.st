tests
testCopyOut1

	| ws |
	self dropTestCopyInOutTable.
	self createTestCopyInOutTable.
	ws := WriteStream on: (String new: 512).
	self copy: 'copy TestCopyInOutTable to stdout' withStream: ws.
	"Transcript show: ws contents printString; cr."
	self assert: ws contents = (String with: $\ with: $. with: Character lf).
