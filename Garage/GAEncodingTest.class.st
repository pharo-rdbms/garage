Class {
	#name : #GAEncodingTest,
	#superclass : #GADriverTest,
	#category : 'Garage-Tests'
}

{ #category : #'as yet unclassified' }
GAEncodingTest class >> isAbstract [

	^ self == GAEncodingTest 
]

{ #category : #accessing }
GAEncodingTest >> encoding [

	self subclassResponsibility
]

{ #category : #running }
GAEncodingTest >> performTest [

	(fixture driver supportsEncoding: self encoding) ifFalse: [ ^ self skip ].
	^ super performTest.
]

{ #category : #running }
GAEncodingTest >> setUp [

	"super setUp."	
	fixture := Fixture ifNil: [ self createFixture ].
	
	(fixture driver supportsEncoding: self encoding) ifFalse: [ ^ self skip ].
	
	fixture setUp: {'encoding' -> self encoding} asDictionary.
	conn := fixture connection.
]

{ #category : #tests }
GAEncodingTest >> testEncodeArgumentsInPreparedStatements [
	| tmp1 tmp2 tmp3 |
	conn supportsPreparedStatements
		ifFalse: [ ^ self skip ].
	tmp1 := 'áèîÑçö'.
	tmp3 := conn
		prepare: 'INSERT INTO student(id, description) VALUES(1, ?)'.
	tmp3
		at: 1 bind: tmp1;
		execute.
	tmp2 := conn execute: 'SELECT description FROM student WHERE id=1'.
	self assert: (tmp2 first at: 1) equals: tmp1
]

{ #category : #tests }
GAEncodingTest >> testEncoder [

	self assert: conn encoder equals: (ZnCharacterEncoder newForEncoding: self encoding)
]

{ #category : #tests }
GAEncodingTest >> testSpecialCharacters [
	| tmp1 tmp2 |
	conn supportsAutomaticQueryEncoding
		ifTrue: [ ^ self skip ].
	tmp1 := 'áèîÑçö'.
	conn
		execute:
			'INSERT INTO student(id, description) VALUES(1, '''
				, (conn encoder encodeString: tmp1) asString , ''')'.
	tmp2 := conn execute: 'SELECT description FROM student WHERE id=1'.
	self assert: (tmp2 first at: 1) equals: tmp1
]

{ #category : #tests }
GAEncodingTest >> testSpecialCharacters2 [
	| tmp1 tmp2 |
	conn supportsAutomaticQueryEncoding
		ifTrue: [ ^ self skip ].
	tmp1 := 'î℉ yõù g𐌹ѷЄ ΣϘГくטƏ UTF-8, it stores it'.
	conn
		execute:
			'INSERT INTO student(id, description) VALUES(1, '''
				, (conn encoder encodeString: tmp1) asString , ''')'.
	tmp2 := conn execute: 'SELECT description FROM student WHERE id=1'.
	self assert: (tmp2 first at: 1) equals: tmp1
]

{ #category : #tests }
GAEncodingTest >> testSpecialCharacters2WithoutQueryEncoding [
	| tmp1 tmp2 |
	conn supportsAutomaticQueryEncoding
		ifFalse: [ ^ self skip ].
	tmp1 := 'î℉ yõù g𐌹ѷЄ ΣϘГくטƏ UTF-8, it stores it'.
	conn
		execute: 'INSERT INTO student(id, description) VALUES(1, ''' , tmp1 , ''')'.
	tmp2 := conn execute: 'SELECT description FROM student WHERE id=1'.
	self assert: (tmp2 first at: 1) equals: tmp1
]

{ #category : #tests }
GAEncodingTest >> testSpecialCharacters3 [
	| tmp1 tmp2 |
	conn supportsAutomaticQueryEncoding
		ifTrue: [ ^ self skip ].
	tmp1 := 'öäüßøæ¢'.
	conn
		execute:
			'INSERT INTO student(id, description) VALUES(1, '''
				, (conn encoder encodeString: tmp1) asString , ''')'.
	tmp2 := conn execute: 'SELECT description FROM student WHERE id=1'.
	self assert: (tmp2 first at: 1) equals: tmp1
]

{ #category : #tests }
GAEncodingTest >> testSpecialCharacters3WithoutQueryEncoding [
	| tmp1 tmp2 |
	conn supportsAutomaticQueryEncoding
		ifFalse: [ ^ self skip ].
	tmp1 := 'öäüßøæ¢'.
	conn
		execute: 'INSERT INTO student(id, description) VALUES(1, ''' , tmp1 , ''')'.
	tmp2 := conn execute: 'SELECT description FROM student WHERE id=1'.
	self assert: (tmp2 first at: 1) equals: tmp1
]

{ #category : #tests }
GAEncodingTest >> testSpecialCharactersWithoutQueryEncoding [
	| tmp1 tmp2 |
	conn supportsAutomaticQueryEncoding
		ifFalse: [ ^ self skip ].
	tmp1 := 'áèîÑçö'.
	conn
		execute: 'INSERT INTO student(id, description) VALUES(1, ''' , tmp1 , ''')'.
	tmp2 := conn execute: 'SELECT description FROM student WHERE id=1'.
	self assert: (tmp2 first at: 1) equals: tmp1
]
