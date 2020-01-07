Class {
	#name : #GAPreparedStamentTest,
	#superclass : #GADriverTest,
	#category : 'Garage-Tests'
}

{ #category : #'as yet unclassified' }
GAPreparedStamentTest >> testBindQuestionMark [
	| result row statement |

	conn supportsPreparedStatements ifFalse: [ ^self skip ].

	conn execute: 'CREATE TABLE CATS (
		name varchar(50),
		owner varchar(50))'.

	conn execute: 'INSERT INTO CATS(name,owner) VALUES(''lutz'',''julien'')'.
	
	statement := conn prepare: 'SELECT * FROM CATS WHERE name=?'.
	statement at: 1 bind: 'lutz'.
	result := statement execute.
	row := result first.
	
	self assert: (row at: 1) equals: 'lutz'.
	self assert: (row at: 2) equals: 'julien'.
]

{ #category : #'as yet unclassified' }
GAPreparedStamentTest >> testBindQuestionMarkFromExistingStatement [
	| result row statement |

	conn supportsPreparedStatements ifFalse: [ ^self skip ].

	statement := conn createStatement: 'CREATE TABLE CATS (
		name varchar(50),
		owner varchar(50))'.
	statement execute.

	statement := conn createStatement: 'INSERT INTO CATS(name,owner) VALUES(''lutz'',''julien'')'.
	statement execute.
	
	statement := conn createStatement: 'SELECT * FROM CATS WHERE name=?'.
	statement prepare.
	statement at: 1 bind: 'lutz'.
	result := statement execute.
	row := result first.
	
	self assert: (row at: 1) equals: 'lutz'.
	self assert: (row at: 2) equals: 'julien'.
]

{ #category : #'as yet unclassified' }
GAPreparedStamentTest >> testBindQuestionMarkFromExistingUninitializedStatement [
	| result row statement |

	conn supportsPreparedStatements ifFalse: [ ^self skip ].

	statement := conn createStatement.
	statement statementString: 'CREATE TABLE CATS (
		name varchar(50),
		owner varchar(50))'.
	statement execute.

	statement := conn createStatement.
	statement statementString: 'INSERT INTO CATS(name,owner) VALUES(''lutz'',''julien'')'.
	statement execute.
	
	statement := conn createStatement.
	statement statementString: 'SELECT * FROM CATS WHERE name=' , (statement placeholderAt: 1).
	statement prepare.
	statement at: 1 bind: 'lutz'.
	result := statement execute.
	row := result first.
	
	self assert: (row at: 1) equals: 'lutz'.
	self assert: (row at: 2) equals: 'julien'.
]

{ #category : #'as yet unclassified' }
GAPreparedStamentTest >> testBindingFailsIfNotSupportedPrepare [

	| statement |
	conn supportsPreparedStatements ifTrue: [ self skip ].
	statement := conn createStatement.
	statement statementString:  'SELECT * FROM CATS WHERE owner = ?'.
	self should: [ statement at: 1 bind: 'guille' ] raise: Error.
]

{ #category : #'as yet unclassified' }
GAPreparedStamentTest >> testPrepareInsert [
	| result row preparedStatement |
	conn supportsPreparedStatements ifFalse: [ ^self skip ].

	conn execute: 'INSERT INTO student(id) VALUES (1)'.
	preparedStatement := conn prepare: 'INSERT INTO signature(code, name, observations, id_student) VALUES (59, ''TADP'', ''Tecnicas Av'', 1)'.
	preparedStatement execute.
	
	result := conn execute: 'SELECT code, name, observations, id_student FROM signature'.
	row := result first.
	
	self assert: (row at: 1) equals: 59.
	self assert: (row at: 2) equals: 'TADP'.
	self assert: (row at: 3) equals: 'Tecnicas Av'.
	self assert: (row at: 4) equals: 1.
]

{ #category : #'as yet unclassified' }
GAPreparedStamentTest >> testPrepareInsertFromExistingStatement [
	| result row preparedStatement statement |
	conn supportsPreparedStatements ifFalse: [ ^self skip ].

	conn execute: 'INSERT INTO student(id) VALUES (1)'.
	statement := conn createStatement: 'INSERT INTO signature(code, name, observations, id_student) VALUES (59, ''TADP'', ''Tecnicas Av'', 1)'.
	preparedStatement := statement prepare.
	preparedStatement execute.
	
	result := conn execute: 'SELECT code, name, observations, id_student FROM signature'.
	row := result first.
	
	self assert: (row at: 1) equals: 59.
	self assert: (row at: 2) equals: 'TADP'.
	self assert: (row at: 3) equals: 'Tecnicas Av'.
	self assert: (row at: 4) equals: 1.
]

{ #category : #'as yet unclassified' }
GAPreparedStamentTest >> testPrepareInsertFromExistingUninitializedStatement [
	| result row preparedStatement statement |
	conn supportsPreparedStatements ifFalse: [ ^self skip ].

	conn execute: 'INSERT INTO student(id) VALUES (1)'.
	statement := conn createStatement.
	statement statementString: 'INSERT INTO signature(code, name, observations, id_student) VALUES (59, ''TADP'', ''Tecnicas Av'', 1)'.
	preparedStatement := statement prepare.
	preparedStatement execute.
	
	result := conn execute: 'SELECT code, name, observations, id_student FROM signature'.
	row := result first.
	
	self assert: (row at: 1) equals: 59.
	self assert: (row at: 2) equals: 'TADP'.
	self assert: (row at: 3) equals: 'Tecnicas Av'.
	self assert: (row at: 4) equals: 1.
]

{ #category : #'as yet unclassified' }
GAPreparedStamentTest >> testPrepareSelect [
	| result row preparedStatement |
	conn supportsPreparedStatements ifFalse: [ ^self skip ].
	
	conn execute: 'INSERT INTO student(id) VALUES (1)'.
	conn execute: 'INSERT INTO signature(code, name, observations, id_student) VALUES (59, ''TADP'', ''Tecnicas Av'', 1)'.
	
	preparedStatement := conn prepare: 'SELECT code, name, observations, id_student FROM signature'.
	result := preparedStatement execute.
	row := result first.
	
	self assert: (row at: 1) equals: 59.
	self assert: (row at: 2) equals: 'TADP'.
	self assert: (row at: 3) equals: 'Tecnicas Av'.
	self assert: (row at: 4) equals: 1.
]

{ #category : #'as yet unclassified' }
GAPreparedStamentTest >> testPrepareSelectFromExistingStatement [
	| result row statement |
	conn supportsPreparedStatements ifFalse: [ ^self skip ].
	
	conn execute: 'INSERT INTO student(id) VALUES (1)'.
	conn execute: 'INSERT INTO signature(code, name, observations, id_student) VALUES (59, ''TADP'', ''Tecnicas Av'', 1)'.
	
	statement := conn createStatement: 'SELECT code, name, observations, id_student FROM signature'.
	result := statement prepare execute.
	row := result first.
	
	self assert: (row at: 1) equals: 59.
	self assert: (row at: 2) equals: 'TADP'.
	self assert: (row at: 3) equals: 'Tecnicas Av'.
	self assert: (row at: 4) equals: 1.
]

{ #category : #'as yet unclassified' }
GAPreparedStamentTest >> testPrepareSelectFromExistingUninitializedStatement [
	| result row preparedStatement |
	conn supportsPreparedStatements ifFalse: [ ^self skip ].
	
	conn execute: 'INSERT INTO student(id) VALUES (1)'.
	conn execute: 'INSERT INTO signature(code, name, observations, id_student) VALUES (59, ''TADP'', ''Tecnicas Av'', 1)'.
	
	preparedStatement := conn createStatement.
	preparedStatement statementString:  'SELECT code, name, observations, id_student FROM signature'.
	preparedStatement prepare.
	result := preparedStatement execute.
	row := result first.
	
	self assert: (row at: 1) equals: 59.
	self assert: (row at: 2) equals: 'TADP'.
	self assert: (row at: 3) equals: 'Tecnicas Av'.
	self assert: (row at: 4) equals: 1.
]

{ #category : #'as yet unclassified' }
GAPreparedStamentTest >> testPrepareWithArgs [
	| result row preparedStatement |
	conn supportsPreparedStatements ifFalse: [ ^self skip ].
	
	conn execute: 'INSERT INTO student(id) VALUES (1)'.
	preparedStatement := conn prepare: 'INSERT INTO signature(code, name, observations, id_student) VALUES (59, ''TADP'', ''Tecnicas Av'', ?)'.
	preparedStatement at: 1 bind: 1.
	preparedStatement execute.
	
	preparedStatement := conn prepare: 'SELECT code, name, observations, id_student FROM signature WHERE id_student = ?'.
	preparedStatement at: 1 bind: 1.
	result := preparedStatement execute.
	row := result first.
	
	self assert: (row at: 1) equals: 59.
	self assert: (row at: 2) equals: 'TADP'.
	self assert: (row at: 3) equals: 'Tecnicas Av'.
	self assert: (row at: 4) equals: 1.
]

{ #category : #'as yet unclassified' }
GAPreparedStamentTest >> testPrepareWithArgsFromExistingStatement [
	| result row preparedStatement |
	conn supportsPreparedStatements ifFalse: [ ^self skip ].
	
	conn execute: 'INSERT INTO student(id) VALUES (1)'.
	preparedStatement := conn createStatement: 'INSERT INTO signature(code, name, observations, id_student) VALUES (59, ''TADP'', ''Tecnicas Av'', ?)'.
	preparedStatement prepare.
	preparedStatement at: 1 bind: 1.
	preparedStatement execute.
	
	preparedStatement := conn createStatement: 'SELECT code, name, observations, id_student FROM signature WHERE id_student = ?'.
	preparedStatement prepare.
	preparedStatement at: 1 bind: 1.
	result := preparedStatement execute.
	row := result first.
	
	self assert: (row at: 1) equals: 59.
	self assert: (row at: 2) equals: 'TADP'.
	self assert: (row at: 3) equals: 'Tecnicas Av'.
	self assert: (row at: 4) equals: 1.
]

{ #category : #'as yet unclassified' }
GAPreparedStamentTest >> testPrepareWithArgsFromExistingUninitializedStatement [
	| result row preparedStatement |
	conn supportsPreparedStatements ifFalse: [ ^self skip ].
	
	conn execute: 'INSERT INTO student(id) VALUES (1)'.
	preparedStatement := conn prepare: 'INSERT INTO signature(code, name, observations, id_student) VALUES (59, ''TADP'', ''Tecnicas Av'', ?)'.
	preparedStatement at: 1 bind: 1.
	preparedStatement execute.
	
	preparedStatement := conn createStatement.
	preparedStatement statementString: 'SELECT code, name, observations, id_student FROM signature WHERE id_student = ',(preparedStatement placeholderAt: 1).
	preparedStatement prepare.
	preparedStatement at: 1 bind: 1.
	result := preparedStatement execute.
	row := result first.
	
	self assert: (row at: 1) equals: 59.
	self assert: (row at: 2) equals: 'TADP'.
	self assert: (row at: 3) equals: 'Tecnicas Av'.
	self assert: (row at: 4) equals: 1.
]

{ #category : #'as yet unclassified' }
GAPreparedStamentTest >> testPrepareWithUnboundArgsWithDriversThatChooseADefault [
	| preparedStatement |
	conn supportsPreparedStatements ifFalse: [ ^self skip ].
	conn notBoundArgumentsFail ifTrue: [ ^self skip ].
	"Not bound arguments are taken as NULL"
	
	preparedStatement := conn prepare: 'INSERT INTO signature(code, name, observations, id_student) VALUES (59, ''TADP'', ''Tecnicas Av'', ?)'.
	preparedStatement execute.
	
	(conn execute: 'SELECT id_student FROM signature') do: [ :r | self assert: (r at: 1) isNil ]
]

{ #category : #'as yet unclassified' }
GAPreparedStamentTest >> testPrepareWithUnboundArgsWithDriversThatChooseADefaultFromExistingStatement [
	| preparedStatement |
	conn supportsPreparedStatements ifFalse: [ ^self skip ].
	conn notBoundArgumentsFail ifTrue: [ ^self skip ].
	"Not bound arguments are taken as NULL"
	
	preparedStatement := conn createStatement: 'INSERT INTO signature(code, name, observations, id_student) VALUES (59, ''TADP'', ''Tecnicas Av'', ?)'.
	preparedStatement prepare.
	preparedStatement execute.
	
	(conn execute: 'SELECT id_student FROM signature') do: [ :r | self assert: (r at: 1) isNil ]
]

{ #category : #'as yet unclassified' }
GAPreparedStamentTest >> testPrepareWithUnboundArgsWithDriversThatChooseADefaultFromExistingUninitializedStatement [
	| preparedStatement |
	conn supportsPreparedStatements ifFalse: [ ^self skip ].
	conn notBoundArgumentsFail ifTrue: [ ^self skip ].
	"Not bound arguments are taken as NULL"
	
	preparedStatement := conn createStatement.
	preparedStatement statementString: 'INSERT INTO signature(code, name, observations, id_student) VALUES (59, ''TADP'', ''Tecnicas Av'', ?)'.
	preparedStatement prepare.
	preparedStatement execute.
	
	(conn execute: 'SELECT id_student FROM signature') do: [ :r | self assert: (r at: 1) isNil ]
]

{ #category : #'as yet unclassified' }
GAPreparedStamentTest >> testPrepareWithWrongArgs [
	| preparedStatement |
	conn supportsPreparedStatements ifFalse: [ ^self skip ].
	conn notBoundArgumentsFail ifFalse: [ self skip ].
	
	preparedStatement := conn prepare: 'INSERT INTO signature(code, name, observations, id_student) VALUES (59, ''TADP'', ''Tecnicas Av'', ?)'.
	self should: [preparedStatement execute] raise: Error.
]

{ #category : #'as yet unclassified' }
GAPreparedStamentTest >> testPrepareWithWrongArgsFromExistingStatement [
	| preparedStatement |
	conn supportsPreparedStatements ifFalse: [ ^self skip ].
	conn notBoundArgumentsFail ifFalse: [ self skip ].
	
	preparedStatement := conn createStatement: 'INSERT INTO signature(code, name, observations, id_student) VALUES (59, ''TADP'', ''Tecnicas Av'', ?)'.
	preparedStatement prepare.
	self should: [preparedStatement execute] raise: Error.
]

{ #category : #'as yet unclassified' }
GAPreparedStamentTest >> testPrepareWithWrongArgsFromExistingUninitializedStatement [
	| preparedStatement |
	conn supportsPreparedStatements ifFalse: [ ^self skip ].
	conn notBoundArgumentsFail ifFalse: [ self skip ].
	
	preparedStatement := conn createStatement.
	preparedStatement statementString: 'INSERT INTO signature(code, name, observations, id_student) VALUES (59, ''TADP'', ''Tecnicas Av'', ',(preparedStatement placeholderAt: 1),')'.
	preparedStatement prepare.
	self should: [preparedStatement execute] raise: Error.
]

{ #category : #'as yet unclassified' }
GAPreparedStamentTest >> testStatementNotPreparedIfNotSuported [

	"If we send non-sense, drivers that support prepared statements will fail on preparation and the others will fail on execute as there is no real preparation"
	conn supportsPreparedStatements ifTrue: [ ^ self skip ].
	self should: [conn prepare: 'SELECT 1+1'] raise: Error.
]

{ #category : #'as yet unclassified' }
GAPreparedStamentTest >> testStatementNotPreparedIfNotSuportedFromExistingStatement [

	"If we send non-sense, drivers that support prepared statements will fail on preparation and the others will fail on execute as there is no real preparation"
	| preparedStatement |
	conn supportsPreparedStatements ifTrue: [ ^ self skip ].
	preparedStatement := conn createStatement: 'SELECT 1+1'.
	self should: [ preparedStatement prepare ] raise: Error.
]

{ #category : #'as yet unclassified' }
GAPreparedStamentTest >> testStatementNotPreparedIfNotSuportedFromExistingUninitializedStatement [

	"If we send non-sense, drivers that support prepared statements will fail on preparation and the others will fail on execute as there is no real preparation"
	| statement |
	conn supportsPreparedStatements ifTrue: [ ^ self skip ].
	statement := conn createStatement.
	statement statementString: 'SELECT 1+1'.
	self should: [ conn prepare ] raise: Error.
]
