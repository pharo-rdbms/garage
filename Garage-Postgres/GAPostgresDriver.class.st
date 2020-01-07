Class {
	#name : #GAPostgresDriver,
	#superclass : #GADriver,
	#instVars : [
		'driver',
		'connectionSpec'
	],
	#category : 'Garage-Postgres-Driver'
}

{ #category : #drivers }
GAPostgresDriver class >> driverId [

	^ 'postgresV2'
]

{ #category : #'instance-creation' }
GAPostgresDriver class >> fromConnectionString: aConnectionString [
	
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
GAPostgresDriver class >> initialize [

	self subscribeDriver
]

{ #category : #tests }
GAPostgresDriver class >> newFixture [
	
	^ GADriverPostgresqlTestFixture new
]

{ #category : #encoding }
GAPostgresDriver class >> supportsEncoding: aString [ 
	
	"Check: http://www.postgresql.org/docs/9.2/static/multibyte.html"
	^ true
]

{ #category : #accessing }
GAPostgresDriver >> backend [
	
	^ 'postgresql'
]

{ #category : #private }
GAPostgresDriver >> basicQuery: aQuery [
	
	^ driver executeAndCheckResult: aQuery.

]

{ #category : #transactions }
GAPostgresDriver >> beginTransaction [
	
	^ self basicQuery: 'BEGIN'
]

{ #category : #connection }
GAPostgresDriver >> close [

	driver ifNotNil: #close
]

{ #category : #transactions }
GAPostgresDriver >> commitTransaction [
	
	^ self basicQuery: 'COMMIT'
]

{ #category : #connection }
GAPostgresDriver >> connect [

	| response |
	driver := GAConnection new
		connectionArgs: connectionSpec;
		clientEncoding: self encoding asSymbol;
		yourself.
	response := driver startup.
	(response errorResponse isKindOf: GAErrorResponse)
		ifTrue: [ self error: response errorResponse value ].
	self register.
]

{ #category : #statements }
GAPostgresDriver >> createStatement [
	
	^ GAPostgresStatement onConnection: self.
]

{ #category : #query }
GAPostgresDriver >> createStatement: aQuery [
	
	| statement pgGoodQuery |
	pgGoodQuery := self pgGoodQuery: aQuery.
	statement := GAPostgresStatement onConnection: self.
	statement statementString: pgGoodQuery.
	^ statement
]

{ #category : #accessing }
GAPostgresDriver >> database [
	
	^ connectionSpec databaseName
]

{ #category : #accessing }
GAPostgresDriver >> database: aDatabase [
	
	connectionSpec databaseName: aDatabase
]

{ #category : #transactions }
GAPostgresDriver >> defaultValueAutoCommit [
	
	^ true
]

{ #category : #accessing }
GAPostgresDriver >> driverId [
	
	^ self class driverId
]

{ #category : #query }
GAPostgresDriver >> execute: aQuery [

	^ driver executeAndCheckResult: aQuery
]

{ #category : #finalization }
GAPostgresDriver >> finalize [

	self isConnected ifTrue: [ self close ].
	driver := nil
]

{ #category : #transactions }
GAPostgresDriver >> hasAutoCommit [
	
	^ true
]

{ #category : #accessing }
GAPostgresDriver >> host [
	
	^ connectionSpec hostname
]

{ #category : #accessing }
GAPostgresDriver >> host: aHost [

	connectionSpec hostname: aHost
]

{ #category : #initialization }
GAPostgresDriver >> initialize [

	super initialize.
	connectionSpec := GAConnectionArgs new
]

{ #category : #testing }
GAPostgresDriver >> isConnected [
	
	^ driver notNil and: [ driver isConnected ]
]

{ #category : #'as yet unclassified' }
GAPostgresDriver >> newFixture [

	^ GADriverPostgresqlTestFixture new
]

{ #category : #accessing }
GAPostgresDriver >> password [
	
	^ connectionSpec password
]

{ #category : #accessing }
GAPostgresDriver >> password: aPort [

	connectionSpec password: aPort
]

{ #category : #conversion }
GAPostgresDriver >> pgGoodQuery: aQuery [
	
	| goodQuery next index lastIndex |
	goodQuery := ''.
	lastIndex := 0.
	next := 1.
	[index := aQuery findString: '?' startingAt: lastIndex + 1 caseSensitive: true. index = 0] 
		whileFalse: [
			goodQuery := goodQuery , (aQuery copyFrom: lastIndex + 1 to: index -1).
			goodQuery := goodQuery , '$', next asString.
			lastIndex := index.
			next := next + 1 ].
	goodQuery := goodQuery , (aQuery copyFrom: lastIndex + 1 to: aQuery size).
	^ goodQuery
]

{ #category : #accessing }
GAPostgresDriver >> port [
	
	^ connectionSpec portno
]

{ #category : #accessing }
GAPostgresDriver >> port: aPort [

	connectionSpec portno: aPort
]

{ #category : #query }
GAPostgresDriver >> prepare: aQuery [

	^ (self createStatement: aQuery) prepare
]

{ #category : #transactions }
GAPostgresDriver >> rollbackTransaction [
	
	self basicQuery: 'ROLLBACK'
]

{ #category : #testing }
GAPostgresDriver >> supportsAutomaticQueryEncoding [
	
	^ true
]

{ #category : #testing }
GAPostgresDriver >> supportsCursoredFetch [
	
	^ true
]

{ #category : #testing }
GAPostgresDriver >> supportsPreparedStatements [

	^ true
]

{ #category : #accessing }
GAPostgresDriver >> user [
	
	^ connectionSpec userName
]

{ #category : #accessing }
GAPostgresDriver >> user: username [

	connectionSpec userName: username
]
