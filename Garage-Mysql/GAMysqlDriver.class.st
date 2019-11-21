"
I am a driver implementation to connect with Mysql databases.
I use the binary and textual protocol of mysql, connecting to a database through a socket.
"
Class {
	#name : #GAMysqlDriver,
	#superclass : #GADriver,
	#instVars : [
		'connectionSpec',
		'netSession',
		'handshakeInfo'
	],
	#category : 'Garage-Mysql-Driver'
}

{ #category : #drivers }
GAMysqlDriver class >> driverId [

	^ 'mysql'
]

{ #category : #'instance-creation' }
GAMysqlDriver class >> fromConnectionString: aConnectionString [
	
	| connection |
	connection := self new.
	connection connectionString: aConnectionString.
	connection host: aConnectionString host.
	connection port: aConnectionString port asInteger.
	connection database: aConnectionString database.
	connection user: aConnectionString user.
	connection password: aConnectionString password.
	^ connection
]

{ #category : #initialize }
GAMysqlDriver class >> initialize [

	self subscribeDriver
]

{ #category : #tests }
GAMysqlDriver class >> newFixture [
	
	^ GADriverMysqlTestFixture new
]

{ #category : #encoding }
GAMysqlDriver class >> supportsEncoding: aString [ 
	
	"Mysql only supports in the client encodings that are compatible with ascii.
	Cite: ucs2, utf16, and utf32 cannot be used as a client character set, which means that they do not work for SET NAMES or SET CHARACTER SET."
	
	" check 
	  https://dev.mysql.com/doc/refman/5.5/en/charset-charsets.html
	  https://dev.mysql.com/doc/refman/5.5/en/charset-connection.html"
	^ 'utf8' = aString
]

{ #category : #testing }
GAMysqlDriver >> affectsOnlyChangedRows [

	^ true
]

{ #category : #connection }
GAMysqlDriver >> assertConnection [

	self isConnected ifFalse: [^ GAMysqlNoConnectionError signal: 'Driver is not connected'].
]

{ #category : #connection }
GAMysqlDriver >> authenticate [

	| auth response |
	handshakeInfo := GAMysqlHandshake from: netSession read.
	handshakeInfo supportsProtocol41 
		ifFalse: [ GAMysqlUnsupportedProtocolError signal: 'Server does not support protocol version 41' ].
	
	auth := GAMysqlClientAuth new
		serverCaps: handshakeInfo serverCaps;
		charset: handshakeInfo serverLang;
		user: self user;
		password: self password;
		database: self database;
		scrambleBuff: handshakeInfo scrambleBuff ;
		scrambleBuffMore: handshakeInfo scrambleBuffMore;
		yourself.
	netSession write: auth write.
	response := self peekPacket.
	
	response isEof ifTrue: [ | scrmblPkt |
		"Read the send short hash indicator: sinsgle eof(254) byte)"
		GAMysqlPacket from: netSession read.
		"This is an indication that comes from server if the password for this user
		follows the old style (short hash) instead of the new style (long hash). 
		We need to send back the 323 scramble"
		scrmblPkt := GAMysql323Scramble new.
		scrmblPkt password: self password; scrambleBuff: handshakeInfo scrambleBuff.
		netSession write: scrmblPkt write.
		response := self peekPacket ].
	^ response
]

{ #category : #accessing }
GAMysqlDriver >> backend [
	
	^ 'mysql'
]

{ #category : #statements }
GAMysqlDriver >> basicPrepare: aQuery [

	| prepStmt prepResp |
	self assertConnection.		
	prepStmt := GAMysqlCommandPrepareStatement onSession: netSession driver: self.
	prepStmt queryString: aQuery.
	prepResp := prepStmt execute. "error or prepare reponse"
	^ prepResp
]

{ #category : #private }
GAMysqlDriver >> basicQuery: queryString [
	
	| response qry |
	self assertConnection.		
	qry := GAMysqlCommandQuery onSession: netSession driver: self.
	qry driver: self.
	qry queryString: queryString.
	response := qry execute.
	response isError ifTrue: [ self error: response message ].	
	^ response
]

{ #category : #transaction }
GAMysqlDriver >> beginTransaction [
	
	self basicQuery: 'BEGIN'
]

{ #category : #connection }
GAMysqlDriver >> close [

	self assertConnection.
	(GAMysqlCommandQuit  onSession: netSession driver: self) execute.
	netSession disconnect.
	
]

{ #category : #transaction }
GAMysqlDriver >> commitTransaction [
	
	self basicQuery: 'COMMIT'
]

{ #category : #connection }
GAMysqlDriver >> connect [
	| response |
	self isConnected ifTrue: [^ GAMysqlDriverError signal: 'Driver is already connected'].
	netSession := GAMysqlNetSession new
						toHost: self host andPort: self port;
						yourself.

	response := self authenticate.
	response isError ifTrue: [ GAMysqlDriverError signal: 'Failed to connect to server: ', (GAMysqlError from: netSession read) message ].

	"We tell the database the encoding we will be using. We could do it in the authenticate but we should have on the client side a table with all possible encodings and values"
	self basicQuery: 'SET NAMES ', self encoding.
	
	self register.
	^ GAMysqlOkay from: netSession read
]

{ #category : #statements }
GAMysqlDriver >> createStatement [
	
	^ GAMysqlStatement onConnection: self.
	
]

{ #category : #statements }
GAMysqlDriver >> createStatement: aSqlStatement [
	
	^ self createStatement
		statementString: aSqlStatement;
		yourself
]

{ #category : #accessing }
GAMysqlDriver >> database [
	
	^ connectionSpec db
]

{ #category : #accessing }
GAMysqlDriver >> database: aDatabase [
	
	connectionSpec database: aDatabase
]

{ #category : #transaction }
GAMysqlDriver >> defaultValueAutoCommit [
	
	^ true
]

{ #category : #accessing }
GAMysqlDriver >> driverId [
	
	^ 'mysql'
]

{ #category : #encoding }
GAMysqlDriver >> encoding [
	
	| encoding |
	encoding := connectionString optionAt: 'encoding' ifAbsent: 'utf8mb4'.
	^ (encoding = 'utf8') ifTrue: [ 'utf8mb4' ] ifFalse: [ encoding ]
]

{ #category : #query }
GAMysqlDriver >> execute: aQuery [

	^ self basicQuery: aQuery
]

{ #category : #finalization }
GAMysqlDriver >> finalize [

	self isConnected ifTrue: [ self close ].
]

{ #category : #testing }
GAMysqlDriver >> hasAutoCommit [
	
	^ ((self execute: 'SHOW SESSION VARIABLES LIKE ''autocommit''')
		first atName: 'Value') = 'ON'.
]

{ #category : #accessing }
GAMysqlDriver >> host [
	
	^ connectionSpec host
]

{ #category : #accessing }
GAMysqlDriver >> host: aHost [

	connectionSpec host: aHost
]

{ #category : #initialization }
GAMysqlDriver >> initialize [

	super initialize.
	connectionSpec := GAMysqlConnectionData new
]

{ #category : #testing }
GAMysqlDriver >> isConnected [
	
	^ netSession isNil not and: [netSession connected]
]

{ #category : #private }
GAMysqlDriver >> netSession [
	
	^ netSession
]

{ #category : #'instance creation' }
GAMysqlDriver >> newFixture [

	^ GADriverMysqlTestFixture new
]

{ #category : #accessing }
GAMysqlDriver >> password [
	
	^ connectionSpec password
]

{ #category : #accessing }
GAMysqlDriver >> password: aPort [

	connectionSpec password: aPort
]

{ #category : #connection }
GAMysqlDriver >> peekPacket [

	^ GAMysqlPacket from: netSession peek
]

{ #category : #accessing }
GAMysqlDriver >> port [
	
	^ connectionSpec port
]

{ #category : #accessing }
GAMysqlDriver >> port: aPort [

	connectionSpec port: aPort
]

{ #category : #query }
GAMysqlDriver >> prepare: aQuery [
	
	^ (self createStatement: aQuery) prepare
]

{ #category : #transaction }
GAMysqlDriver >> rollbackTransaction [
	
	self basicQuery: 'ROLLBACK'
]

{ #category : #testing }
GAMysqlDriver >> supportsAutomaticQueryEncoding [
	
	^ false
]

{ #category : #testing }
GAMysqlDriver >> supportsCursoredFetch [

	^ true
]

{ #category : #testing }
GAMysqlDriver >> supportsPreparedStatements [

	^ true
]

{ #category : #testing }
GAMysqlDriver >> supportsRetrievingGeneratedKeys [

	^ true
]

{ #category : #accessing }
GAMysqlDriver >> user [
	
	^ connectionSpec user
]

{ #category : #accessing }
GAMysqlDriver >> user: username [

	connectionSpec user: username
]
