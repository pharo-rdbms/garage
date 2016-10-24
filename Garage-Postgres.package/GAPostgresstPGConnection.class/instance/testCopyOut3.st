tests
testCopyOut3

	| ws rs |

	ws := WriteStream on: String new.
	ws nextPutAll: (self makeCopyInOutLine: (Array with: '77' with: 'abcde')).
	ws nextPutAll: (self makeCopyInOutLine: (Array with: '88' with: 'vwxyz')).
	ws nextPutAll: self makeCopyInOutEos.

	self dropTestCopyInOutTable.
	self createTestCopyInOutTable.
	self executeAll: #('insert into TestCopyInOutTable values(77,''abcde'')').
	self executeAll: #('insert into TestCopyInOutTable values(88,''vwxyz'')').

	rs := WriteStream on: (String new: 512).
	self copy: 'copy TestCopyInOutTable to stdout' withStream: rs.

	self assert: rs contents = ws contents.
