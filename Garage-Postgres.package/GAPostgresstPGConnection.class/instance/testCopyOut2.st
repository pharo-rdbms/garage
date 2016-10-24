tests
testCopyOut2

	| ws rs |

	ws := WriteStream on: String new.
	ws nextPutAll: (self makeCopyInOutLine: (Array with: '77' with: 'abcde')).
	ws nextPutAll: self makeCopyInOutEos.

	self dropTestCopyInOutTable.
	self createTestCopyInOutTable.
	self executeAll: #('insert into TestCopyInOutTable values(77,''abcde'')').

	rs := WriteStream on: (String new: 512).
	self copy: 'copy TestCopyInOutTable to stdout' withStream: rs.

	self assert: rs contents = ws contents.
