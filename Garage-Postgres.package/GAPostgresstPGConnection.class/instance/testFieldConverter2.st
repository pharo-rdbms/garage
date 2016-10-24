tests
testFieldConverter2

	| conn result data |

	self dropTestFieldConverterTable.
	self createTestFieldConverterTable.

	conn := self newConnection.
	conn startup.
	result := conn execute:
'INSERT INTO TestFieldConverterTable VALUES (TRUE,FALSE,''A'',''B'',''CD'',77,88,99,11.11,22.22,33.33,''2001-01-01'',''04:05:06'',''abcd'');'.
	result := conn execute: 'select * from TestFieldConverterTable'.
	conn terminate.

	self assert: result rows size = 1.
	data := result rows first data.
	"result rows first inspect."
	self assert: (data at: 1).
	self assert: (data at: 2) not.
	self assert: (data at: 3) = 'A'.
	self assert: (data at: 4) = 'B'.
	self assert: (data at: 5) = 'CD'.
	self assert: (data at: 6) = 77.
	self assert: (data at: 7) = 88.
	self assert: (data at: 8) = 99.
	self assert: ((data at: 9) - 11.11) abs < 0.0001.
	self assert: ((data at: 10) - 22.22) abs < 0.0001.
	self assert: ((data at: 11) - 33.33) abs < 0.0001.
	"self assert: (data at: 12) = (DateAndTime year: 2001 month: 1 day: 1 hour: 0 minute: 0 second: 0)."
	self assert: (data at: 12) = (Date newDay: 1 month: 1 year: 2001).
	self assert: (data at: 13) = (Time fromSeconds: (4*60*60) + (5*60) + 6).
	self assert: (data at: 14) = 'abcd'.
