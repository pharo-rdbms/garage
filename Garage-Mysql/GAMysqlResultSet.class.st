"
I am a simple facade on result set packets, although I behave as a MysqlPacketData. I don't perform a read or write; my clients compose me from specific rasult set packets. I am designed this way to facilitate use of similar metaphors at the connector protocol level. I also behave a multi-result type of packet.
"
Class {
	#name : #GAMysqlResultSet,
	#superclass : #GAResultSet,
	#instVars : [
		'header',
		'fields',
		'fieldsEof',
		'rows',
		'rowsEof',
		'statement',
		'fetchListener'
	],
	#category : 'Garage-Mysql-Driver'
}

{ #category : #iterating }
GAMysqlResultSet >> at: anInteger [ 
	
	[(self hasRowAt: anInteger) not and: [ self canFetchMoreRows ]]
		whileTrue: [ self fetchMoreRows ].
	^ self internalRows at: anInteger
]

{ #category : #cursor }
GAMysqlResultSet >> canFetchMoreRows [

	^ self hasOpenCursor and: [self hasLastRowSent not]
]

{ #category : #iterating }
GAMysqlResultSet >> collect: aBlockClosure [ 
	
	^ self internalRows collect: aBlockClosure
]

{ #category : #iterating }
GAMysqlResultSet >> do: aBlockClosure [ 
	
	self internalRows do: aBlockClosure
]

{ #category : #cursor }
GAMysqlResultSet >> fetchListener: aFetchListener [
		
	fetchListener := aFetchListener
]

{ #category : #cursor }
GAMysqlResultSet >> fetchMoreRows [

	statement fetchRows: statement fetchSize
]

{ #category : #accessing }
GAMysqlResultSet >> fields [
	^ fields 
]

{ #category : #accessing }
GAMysqlResultSet >> fields: flds [
	fields := flds
]

{ #category : #accessing }
GAMysqlResultSet >> fieldsEof [
	^ fieldsEof 
]

{ #category : #accessing }
GAMysqlResultSet >> fieldsEof: eofPkt [ 
	fieldsEof := eofPkt
]

{ #category : #iterating }
GAMysqlResultSet >> first [
	
	^ self internalRows first
]

{ #category : #testing }
GAMysqlResultSet >> hasLastRowSent [
	"This is signaled during cursor based fetch for the rows. Therefore we
	check for the singal in the eof field following the rows in the response."
	^ rowsEof ifNil: [false] ifNotNil: [rowsEof hasLastRowSent]
	
]

{ #category : #testing }
GAMysqlResultSet >> hasMoreResults [
	"Looks like the flag, when set, will be set by the server in both the
	field eof and rowdata eof packets. We are only using field eof here, since
	rowdata eof may not sometimes sent as part of the result set (e.g., cursor)."
	^ fieldsEof hasMoreResults
	
]

{ #category : #cursor }
GAMysqlResultSet >> hasOpenCursor [

	^ fieldsEof hasOpenCursor
]

{ #category : #iterating }
GAMysqlResultSet >> hasRowAt: anInteger [
	
	^ self internalRows size >= anInteger
]

{ #category : #accessing }
GAMysqlResultSet >> header [
	^ header
]

{ #category : #accessing }
GAMysqlResultSet >> header: hdr [
	header := hdr
]

{ #category : #initialization }
GAMysqlResultSet >> initialize [

	super initialize.
	rows := OrderedCollection new.
]

{ #category : #accessing }
GAMysqlResultSet >> internalRows [
	^ rows
]

{ #category : #testing }
GAMysqlResultSet >> isEmpty [
	
	^ self internalRows isEmpty
]

{ #category : #testing }
GAMysqlResultSet >> isError [
	
	^ false
]

{ #category : #parsing }
GAMysqlResultSet >> parse [
	self shouldNotImplement
	
]

{ #category : #streaming }
GAMysqlResultSet >> readStream [
	
	^ GAResultSetReadStream on: self
]

{ #category : #cursor }
GAMysqlResultSet >> rows [

	[ self canFetchMoreRows ] whileTrue: [ self fetchMoreRows ].
	^ self internalRows
]

{ #category : #accessing }
GAMysqlResultSet >> rows: allRows [

	allRows ifNil: [ ^ self ].
	rows addAll: allRows asOrderedCollection
]

{ #category : #accessing }
GAMysqlResultSet >> rowsEof [
	^ rowsEof 
]

{ #category : #accessing }
GAMysqlResultSet >> rowsEof: eofPkt [
	rowsEof := eofPkt
]

{ #category : #iterating }
GAMysqlResultSet >> select: aBlockClosure [ 
	
	^ self internalRows select: aBlockClosure
]

{ #category : #accessing }
GAMysqlResultSet >> serverStatus [
	^ fieldsEof serverStatus
	
]

{ #category : #accessing }
GAMysqlResultSet >> statement: aStatement [ 
	
	statement := aStatement
]
