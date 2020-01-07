Class {
	#name : #GAPostgresstPGConnection,
	#superclass : #TestCase,
	#instVars : [
		'useConnectionDefaults',
		'notificationSubscriberCount'
	],
	#category : 'Garage-Postgres-Tests'
}

{ #category : #private }
GAPostgresstPGConnection >> asFloat8Arg: aFloat [
	"Convert aFloat to a ByteArray for use as a function call argument."

	| word1 word2 bigEndian arg tmp |

	word1 := aFloat basicAt: 1.
	word2 := aFloat basicAt: 2.
	bigEndian := false.
	bigEndian ifTrue: [
			tmp := word1.
			word1 := word2.
			word2 := tmp.
		].
	arg := ByteArray new: 8.
	arg at: 1 put: ((word1 bitShift: -24) bitAnd: 16rFF).
	arg at: 2 put: ((word1 bitShift: -16) bitAnd: 16rFF).
	arg at: 3 put: ((word1 bitShift: -8) bitAnd: 16rFF).
	arg at: 4 put: ((word1 bitShift: 0) bitAnd: 16rFF).
	arg at: 5 put: ((word2 bitShift: -24) bitAnd: 16rFF).
	arg at: 6 put: ((word2 bitShift: -16) bitAnd: 16rFF).
	arg at: 7 put: ((word2 bitShift: -8) bitAnd: 16rFF).
	arg at: 8 put: ((word2 bitShift: 0) bitAnd: 16rFF).
	^ arg

]

{ #category : #private }
GAPostgresstPGConnection >> asFloat8ArgVW: aFloat [
	"Convert aFloat to a ByteArray for use as a function call argument."

	| arg |
	arg := ByteArray new: 8.
	1 to: 8 do: [:i | arg at: i put: (aFloat basicAt: 8 - i + 1)].
	^arg
]

{ #category : #private }
GAPostgresstPGConnection >> copy: sql withStream: aStream [

	| conn |
	conn := self newConnection.
	conn startup.
	conn copy: sql withStream: aStream.
	conn terminate.
]

{ #category : #tests }
GAPostgresstPGConnection >> createJsonFieldConverterTable [

	self executeAll: #('CREATE TABLE jsonfieldconvertertable (jsonField json)').

]

{ #category : #tests }
GAPostgresstPGConnection >> createTestCopyInOutTable [

	self executeAll: #(
			'CREATE TABLE TestCopyInOutTable (
				id integer,
				name text
			)'
		).

]

{ #category : #tests }
GAPostgresstPGConnection >> createTestFieldConverterTable [

	self executeAll: #(
'CREATE TABLE TestFieldConverterTable (
aBool1 boolean,
aBool2 boolean,
aChar char,
aChar1 char(1),
aChar2 char(2),
anInt2 int2,
anInt4 int4,
anInt8 int8,
aFloat4 float4,
aFloat8 float8,
aNumeric numeric,
aDate date,
aTime time,
aText text
)'
		).

]

{ #category : #tests }
GAPostgresstPGConnection >> createTestTable [

	self executeAll: #(
			'CREATE TABLE products (
				product_no integer,
				name text,
				price numeric
			)'
		).

]

{ #category : #tests }
GAPostgresstPGConnection >> dropJsonFieldConverterTable [

	self executeAll: #(
			'DROP TABLE jsonfieldconvertertable'
		).

]

{ #category : #tests }
GAPostgresstPGConnection >> dropTestCopyInOutTable [

	self executeAll: #(
			'DROP TABLE TestCopyInOutTable'
		).

]

{ #category : #tests }
GAPostgresstPGConnection >> dropTestFieldConverterTable [

	self executeAll: #(
			'DROP TABLE TestFieldConverterTable'
		).

]

{ #category : #tests }
GAPostgresstPGConnection >> dropTestTable [

	self executeAll: #(
			'DROP TABLE products'
		).

]

{ #category : #private }
GAPostgresstPGConnection >> execute: sql on: conn [

	| result resultStream |

	resultStream := ReadWriteStream on: String new.
	result := conn execute: sql.
	result displayResultOn: resultStream.
	^ resultStream contents.

]

{ #category : #private }
GAPostgresstPGConnection >> executeAll: queries [

	self executeAll: queries withDelayForMilliseconds: nil
]

{ #category : #private }
GAPostgresstPGConnection >> executeAll: queries withDelayForMilliseconds: millisecondDelay [

	| conn result |

	conn := self newConnection.
	conn startup.
	queries do: [:each |
		Transcript nextPutAll: 'QUERY: '; nextPutAll: each; cr; flush.
		result := conn execute: each.
		result displayResultOn: Transcript.
		Transcript flush.
		millisecondDelay isNil ifFalse: [
			Transcript nextPutAll: 'Delaying for ', millisecondDelay printString, ' ms...'; cr.
			(Delay forMilliseconds: millisecondDelay) wait.
			Transcript flush.
		].
	].
	conn terminate.
]

{ #category : #private }
GAPostgresstPGConnection >> floatFromByteArray: aByteArray [
	"Convert aByteArray to a Float."

	| word1 word2 aFloat |

	word1 := (aByteArray at: 1) bitShift: 24.
	word1 := word1 bitOr: ((aByteArray at: 2) bitShift: 16).
	word1 := word1 bitOr: ((aByteArray at: 3) bitShift: 8).
	word1 := word1 bitOr: ((aByteArray at: 4) bitShift: 0).
	word2 := (aByteArray at: 5) bitShift: 24.
	word2 := word2 bitOr: ((aByteArray at: 6) bitShift: 16).
	word2 := word2 bitOr: ((aByteArray at: 7) bitShift: 8).
	word2 := word2 bitOr: ((aByteArray at: 8) bitShift: 0).

	aFloat := 0.0.
	aFloat basicAt: 1 put: word1.
	aFloat basicAt: 2 put: word2.
	^aFloat
]

{ #category : #private }
GAPostgresstPGConnection >> floatFromByteArrayVW: aByteArray [
	"Convert aByteArray to a Float."

	| aFloat |
	aFloat := ByteArray new: 8.
	1 to: 8 do: [:i | aFloat at: 8 - i + 1 put: (aByteArray at: i)].
	aFloat changeClassTo: Double.
	^aFloat
]

{ #category : #private }
GAPostgresstPGConnection >> functionCall: oid arguments: arguments [

	| conn result |
	conn := self newConnection.
	conn startup.
	result := conn functionCall: oid arguments: arguments.
	conn terminate.
	^ result

]

{ #category : #tests }
GAPostgresstPGConnection >> makeCopyInOutEos [
	"Answer the COPY IN/OUT end of stream code."

	^ String with: $\ with: $.with: Character lf

]

{ #category : #tests }
GAPostgresstPGConnection >> makeCopyInOutLine: aCollection [

	| ws |
	ws := WriteStream on: (String new: 512).
	aCollection withIndexDo: [:each :i |
		ws nextPutAll: each.
		i < aCollection size ifTrue: [ws tab]
	].
	ws nextPut: Character lf.
	^ ws contents.

]

{ #category : #private }
GAPostgresstPGConnection >> newConnection [

	| conn |

	conn := GAConnection new.
	(useConnectionDefaults isNil or: [useConnectionDefaults not])
		ifTrue: [ conn connectionArgs: GAConnection buildDefaultConnectionArgs ]
		ifFalse: [ GAConnection defaultConnectionArgs: nil. conn connectionArgs: nil ].
	(notificationSubscriberCount notNil and: [notificationSubscriberCount > 0 ])
		ifTrue: [
			1 to: notificationSubscriberCount do: [:i |
				conn addNotificationSubscriber: GANotificationSubscriber new]
		].
	^ conn

]

{ #category : #tests }
GAPostgresstPGConnection >> oidAbs [
	"oid 1395 is abs(float8)"
	^ 1395

]

{ #category : #tests }
GAPostgresstPGConnection >> oidSqrt [
	"oid 1344 is sqrt(float8)"
	^ 1344

]

{ #category : #tests }
GAPostgresstPGConnection >> oidTimenow [

	^ 250

]

{ #category : #'postgres test suite' }
GAPostgresstPGConnection >> regress: testName [

	| inStream conn outStream line pos result sql |

	Transcript show: testName, '--starting test'; cr.
	conn := self newConnection.
	conn startup.

	inStream := FileStream readOnlyFileNamed: 'u:\lib\pgsql\test\regress\sql\', testName, '.sql'.
	outStream := FileStream newFileNamed: testName, '.out'.
	sql := ''.
	[inStream atEnd] whileFalse: [
		line := inStream upTo: Character lf.
		(line beginsWith: '--')
			ifTrue: [outStream nextPutAll: line; cr].
		(line size > 0 and: [(line beginsWith: '--') not]) ifTrue: [
			pos := line findString: '\g'. "\g is psql execute command"
			pos > 0 ifTrue: [line := line copyFrom: 1 to: pos - 1].
			sql := sql, line, String cr.
			(line endsWith: ';') ifTrue: [
				result := conn execute: sql.
				Transcript show: sql; flush.
				outStream nextPutAll: sql.
				result displayResultOn: outStream.
				sql := ''.
			].
		].
	].
	inStream close.
	outStream close.

	conn terminate.
	Transcript show: testName, '--test completed'; cr.

]

{ #category : #'postgres test suite' }
GAPostgresstPGConnection >> regressionTestNames [

	^#(
		#('boolean' 'char' 'name' 'varchar' 'text' 'int2' 'int4' 'int8' 'oid' 'float4' 'float8' 'numeric')
		'strings'
		'numerology'
		#('point' 'lseg' 'box' 'path' 'polygon' 'circle' 'interval' 'timestamp' 'reltime' 'tinterval' 'inet' 'comments' 'oidjoins' 'type_sanity' 'opr_sanity')
		'abstime'
		'geometry'
		'horology'
		'create_function_1'
		'create_type'
		'create_table'
		'create_function_2'
		'copy'
		#('constraints' 'triggers' 'create_misc' 'create_aggregate' 'create_operator' 'create_index')
		'create_view'
		'sanity_check'
		'errors'
		'select'
		#('select_info' 'select_distinct' 'select_distinct_on' 'select_implicit' 'select_having' 'subselect' 'union' 'case' 'join' 'aggregates' 'transactions' 'random' 'portals' 'arrays' 'btree_index' 'hash_index')
		'misc'
		#('select_views' 'alter_table' 'portals_p2' 'rules' 'foreign_key')
		#('limit' 'plpgsql' 'temp')
	)
]

{ #category : #'postgres test suite' }
GAPostgresstPGConnection >> runRegressionTests [
	"TestPGConnection new runRegressionTests"

	self regress: 'drop'.
	(self regressionTestNames at: 1) do: [:each | self regress: each].
	"self regressionTestNames do: [:test |
		test isString
			ifTrue: [self regress: test]
			ifFalse: [test do: [:each | self regress: each]]
	]."

]

{ #category : #tests }
GAPostgresstPGConnection >> sampleJsonObject [
	| jsonObject |
	jsonObject := JsonObject new
		at: 'string' put: 'Hello world';
		at: 'number' put: 10;
		at: 'float' put: 10.2;
		at: 'boolean' put: true;
		at: 'collection' put: #(1 2 3 5 8 11 19);
		at: 'mixedCollection' put: #(1 'Hello' false);
		yourself.
	^ jsonObject
]

{ #category : #tests }
GAPostgresstPGConnection >> supportsJsonType: conn [
	
	^(conn execute: 'SELECT oid,typname from pg_type  WHERE oid = 114') rows size > 0
	
	
]

{ #category : #private }
GAPostgresstPGConnection >> tearDown [

	GAConnection defaultConnectionArgs: nil.

]

{ #category : #tests }
GAPostgresstPGConnection >> testCancelRequest [
	"Test: CancelRequest.

	Set the debug level of the postmaster daemon to 1 or greater.
	Capture the postmaster output in a log file.
	Examine the log file for a cancel request with a matching process id.

	Example, an init.d script containing:
		su -l postgres -s /bin/sh -c ""/usr/bin/pg_ctl  -D $PGDATA -p /usr/bin/postmaster -o '-i -d 1' start  > /var/log/postgresql/log 2>&1"" < /dev/null
	yields a line in the log:
		/usr/bin/postmaster: processCancelRequest: sending SIGINT to process 13142
	"

	| conn |

	conn := self newConnection.
	conn startup.
	conn cancelRequest.
	conn terminate.

]

{ #category : #tests }
GAPostgresstPGConnection >> testConnection [
	"Test: connect and disconnect, without any queries."

	self executeAll: #().

]

{ #category : #tests }
GAPostgresstPGConnection >> testCopyIn1 [

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

]

{ #category : #tests }
GAPostgresstPGConnection >> testCopyIn2 [

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

]

{ #category : #tests }
GAPostgresstPGConnection >> testCopyOut1 [

	| ws |
	self dropTestCopyInOutTable.
	self createTestCopyInOutTable.
	ws := WriteStream on: (String new: 512).
	self copy: 'copy TestCopyInOutTable to stdout' withStream: ws.
	"Transcript show: ws contents printString; cr."
	self assert: ws contents = (String with: $\ with: $. with: Character lf).

]

{ #category : #tests }
GAPostgresstPGConnection >> testCopyOut2 [

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

]

{ #category : #tests }
GAPostgresstPGConnection >> testCopyOut3 [

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

]

{ #category : #tests }
GAPostgresstPGConnection >> testExecute1 [

	self executeAll: #(
			'select timenow()'
			'select abs(-1)'
		).

]

{ #category : #tests }
GAPostgresstPGConnection >> testExecute2 [

	self executeAll: #(
			'select timenow(); select abs(-1)'
		).

]

{ #category : #tests }
GAPostgresstPGConnection >> testExecuteUsingConnectionDefaults [

	useConnectionDefaults := true.
	self executeAll: #(
			'select timenow()'
			'select abs(-1)'
		).

]

{ #category : #tests }
GAPostgresstPGConnection >> testFieldConverter [
	"Test: two different connections can have a different field converter for a given typeOid.

	This capability would be useful when using one image to connect to two different databases,
	where the same (custom) typeOid is defined differently in each database.
	"

	| conn1 result1 conn2 result2 newConverter |

	self dropTestTable.
	self createTestTable.

	conn1 := self newConnection.
	conn2 := self newConnection.
	conn1 startup.
	conn2 startup.

	result1 := conn1 execute: 'INSERT INTO products VALUES (1);'.
	result1 := conn1 execute: 'select * from products'.

	newConverter := [:value | value].
	conn2 fieldConverterAt: 20 put: newConverter.
	conn2 fieldConverterAt: 21 put: newConverter.
	conn2 fieldConverterAt: 23 put: newConverter.
	result2 := conn2 execute: 'select * from products'.

	conn1 terminate.
	conn2 terminate.

	self assert: result1 rows size = 1.
	self assert: result1 rows first data first = 1.

	self assert: result2 rows size = 1.
	self assert: result2 rows first data first = '1'.

]

{ #category : #tests }
GAPostgresstPGConnection >> testFieldConverter2 [

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

]

{ #category : #tests }
GAPostgresstPGConnection >> testFieldConverter3 [

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

]

{ #category : #tests }
GAPostgresstPGConnection >> testFunctionCall [
	"Test: make several function calls before terminating."

	| conn result arg |
	arg := self asFloat8Arg: 1.0.
	conn := self newConnection.
	conn startup.
	result := conn functionCall: self oidTimenow arguments: OrderedCollection new.
	result := conn functionCall: self oidAbs arguments: (OrderedCollection with: arg).
	result := conn functionCall: self oidSqrt arguments: (OrderedCollection with: arg).
	conn terminate.
	^ result

]

{ #category : #tests }
GAPostgresstPGConnection >> testFunctionCall1 [

	| result |
	result := self functionCall: self oidTimenow arguments: OrderedCollection new.
	self assert: result functionResult notNil.

]

{ #category : #tests }
GAPostgresstPGConnection >> testFunctionCall2 [

	| arg result |
	arg := self asFloat8Arg: -1.0.
	result :=  self functionCall: self oidAbs arguments: (OrderedCollection with: arg).
	self assert: result functionResult notNil.
	self assert: (self floatFromByteArray: result functionResult result) = 1.0.

]

{ #category : #tests }
GAPostgresstPGConnection >> testFunctionCall3 [

	| arg result |
	arg := self asFloat8Arg: 1.0.
	result := self functionCall: self oidSqrt arguments: (OrderedCollection with: arg).
	self assert: result functionResult notNil.
	self assert: (self floatFromByteArray: result functionResult result) = 1.0.

]

{ #category : #tests }
GAPostgresstPGConnection >> testJsonFieldConverter [
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

	

	
	
]

{ #category : #tests }
GAPostgresstPGConnection >> testNotify1 [

	SystemVersion current major >= 7 ifTrue: [ self timeLimit: 1 minute ].
	notificationSubscriberCount := 1.

	[
		self executeAll: #(
			'notify pgtest' 'notify pgtest' 'notify pgtest' 'notify pgtest' 'notify pgtest'
			'notify pgtest' 'notify pgtest' 'notify pgtest' 'notify pgtest' 'notify pgtest'
		) withDelayForMilliseconds: 1000
	] fork.

	self executeAll: #(
		'listen pgtest'
		'select timenow()'
		'select timenow()'
	) withDelayForMilliseconds: 5000

]

{ #category : #tests }
GAPostgresstPGConnection >> testNotify2 [
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

]

{ #category : #'as yet unclassified' }
GAPostgresstPGConnection >> testReadWriteWithEncoding [

	| conn1 result1 |
	self dropTestTable.
	self createTestTable.

	conn1 := self newConnection.
	conn1 connectionArgs clientEncoding: #utf8.
	conn1 startup.

	result1 := conn1 execute: 'INSERT INTO products VALUES (1, ''öäüßøæ¢'');'.
	result1 := conn1 execute: 'select * from products'.

	conn1 terminate.

	self assert: result1 rows size = 1.
	self assert: result1 rows first data second = 'öäüßøæ¢'.

]

{ #category : #tests }
GAPostgresstPGConnection >> testResultSet1 [

	| conn result |

	self dropTestTable.
	self createTestTable.

	conn := self newConnection.
	conn startup.
	result := conn execute: 'insert into products values(77,''abcde'',123.456)'.
	result := conn execute: 'select * from products'.
	conn terminate.

	self assert: result rows size = 1.

]

{ #category : #tests }
GAPostgresstPGConnection >> testResultSet2 [

	| conn result rs1 rs2 |

	self dropTestTable.
	self createTestTable.

	conn := self newConnection.
	conn startup.
	result := conn execute: 'insert into products values(49,''abcde'',123.456)'.
	result := conn execute: 'insert into products values(50,''abcde'',123.456)'.
	result := conn execute: 'insert into products values(51,''abcde'',123.456)'.
	result := conn execute: 'insert into products values(52,''abcde'',123.456)'.
	result := conn execute: 'select * from products; select * from products where product_no > 50'.
	conn terminate.

	rs1 := result resultSets at: 1.
	self assert: rs1 rows size = 4.

	rs2 := result resultSets at: 2.
	self assert: rs2 rows size = 2.

]
