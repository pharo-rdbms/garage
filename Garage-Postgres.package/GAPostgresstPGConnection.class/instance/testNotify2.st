tests
testNotify2
	"Test: a NoticeResponse will be sent because there is an extra field on the input line."

	| ws conn |

	true ifTrue: [ ^ self skip ].
	
	notificationSubscriberCount := 2.

	self dropTestTable.
	self createTestTable.

	ws := WriteStream on: String new.
	ws nextPutAll: (self makeCopyInOutLine: (Array with: '77' with: 'abcde' with: '123.456' with: '999.999')).
	ws nextPutAll: self makeCopyInOutEos.

	conn := self newConnection.
	conn startup.
	conn copy: 'copy products from stdin' withStream: ws.
	conn terminate.
