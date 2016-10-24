tests
testFieldConverter3

	| conn result d |

	self dropTestFieldConverterTable.
	self createTestFieldConverterTable.

	conn := self newConnection.
	conn startup.
	result := conn execute:
'INSERT INTO TestFieldConverterTable VALUES (TRUE,FALSE,''A'',''B'',''CD'',77,88,99,11.11,22.22,33.33,''2001-01-01'',''04:05:06'',''abcd'');'.
	result := conn execute: 'select * from TestFieldConverterTable'.
	conn terminate.

	self assert: result rows size = 1.
	d := result rows first dataKeyedByFieldName.
	"result rows first inspect."
	self assert: (d at: 'aBool1' asLowercase).
	self assert: (d at: 'aBool2' asLowercase) not.
	self assert: (d at: 'aChar' asLowercase) = 'A'.
	self assert: (d at: 'aChar1' asLowercase) = 'B'.
	self assert: (d at: 'aChar2' asLowercase) = 'CD'.
	self assert: (d at: 'anInt2' asLowercase) = 77.
	self assert: (d at: 'anInt4' asLowercase) = 88.
	self assert: (d at: 'anInt8' asLowercase) = 99.
	self assert: ((d at: 'aFloat4' asLowercase) - 11.11) abs < 0.0001.
	self assert: ((d at: 'aFloat8' asLowercase) - 22.22) abs < 0.0001.
	self assert: ((d at: 'aNumeric' asLowercase) - 33.33) abs < 0.0001.
	"self assert: (d at: 'aDate' asLowercase) = (DateAndTime year: 2001 month: 1 day: 1 hour: 0 minute: 0 second: 0)."
	self assert: (d at: 'aDate' asLowercase) = (Date newDay: 1 month: 1 year: 2001).
	self assert: (d at: 'aTime' asLowercase) = (Time fromSeconds: (4*60*60) + (5*60) + 6).
	self assert: (d at: 'aText' asLowercase) = 'abcd'.
