Class {
	#name : #GAQueryTest,
	#superclass : #GADriverTest,
	#category : 'Garage-Tests'
}

{ #category : #tests }
GAQueryTest >> testInsert [
	"self debug: #testInsert"
	| result row |
	
	conn execute: 'INSERT INTO student(id) VALUES (1)'.
	conn execute: 'INSERT INTO signature(code, name, observations, id_student) VALUES (59, ''TADP'', ''Tecnicas Av'', 1)'.
	result := conn execute: 'SELECT code, name, observations, id_student FROM signature'.
	row := result first.
	
	self assert: (row at: 1) equals: 59.
	self assert: (row at: 2) equals: 'TADP'.
	self assert: (row at: 3) equals: 'Tecnicas Av'.
	self assert: (row at: 4) equals: 1.
]

{ #category : #'as yet unclassified' }
GAQueryTest >> testQuery [
	| select result |

	select:= 'SELECT * FROM signature'.
	result := conn execute: select.
]

{ #category : #'as yet unclassified' }
GAQueryTest >> testQueryResult [
	| select result |

	select:= 'SELECT * FROM signature'.
	result := conn execute: select.
	
	self assert: result isEmpty.
]

{ #category : #'as yet unclassified' }
GAQueryTest >> testResultIterateAt [

	| select result |

	conn execute: 'INSERT INTO student(id) VALUES (1)'.
	conn execute: 'INSERT INTO student(id) VALUES (2)'.
	conn execute: 'INSERT INTO signature(code, name, observations, id_student) VALUES (59, ''TADP'', ''Tecnicas Av'', 1)'.
	conn execute: 'INSERT INTO signature(code, name, observations, id_student) VALUES (59, ''TADP'', ''Tecnicas Av'', 2)'.
	select:= 'SELECT code, name, observations, id_student FROM signature'.

	result := conn execute: select.
	self assert: ((result at: 2) atIndex: 4) equals: 2.
]

{ #category : #'as yet unclassified' }
GAQueryTest >> testResultIterateCollect [

	| select result collected |

	conn execute: 'INSERT INTO student(id) VALUES (1)'.
	conn execute: 'INSERT INTO student(id) VALUES (2)'.
	conn execute: 'INSERT INTO signature(code, name, observations, id_student) VALUES (59, ''TADP'', ''Tecnicas Av'', 1)'.
	conn execute: 'INSERT INTO signature(code, name, observations, id_student) VALUES (59, ''TADP'', ''Tecnicas Av'', 2)'.
	select:= 'SELECT code, name, observations, id_student FROM signature'.

	result := conn execute: select.
	collected := result collect: [ :row | row atIndex: 4].

	self assert: collected asArray equals: #(1 2).
]

{ #category : #'as yet unclassified' }
GAQueryTest >> testResultIterateDo [

	| select result rows |

	conn execute: 'INSERT INTO student(id) VALUES (1)'.
	conn execute: 'INSERT INTO student(id) VALUES (2)'.
	conn execute: 'INSERT INTO signature(code, name, observations, id_student) VALUES (59, ''TADP'', ''Tecnicas Av'', 1)'.
	conn execute: 'INSERT INTO signature(code, name, observations, id_student) VALUES (59, ''TADP'', ''Tecnicas Av'', 2)'.
	select:= 'SELECT code, name, observations FROM signature'.

	result := conn execute: select.
	rows := 0.
	result do: [ :row |
		self assert: (row at: 1) equals: 59.
		self assert: (row at: 2) equals: 'TADP'.
		self assert: (row at: 3) equals: 'Tecnicas Av'. 
		rows := rows + 1 ].

	self assert: rows equals: 2.
]

{ #category : #'as yet unclassified' }
GAQueryTest >> testResultIterateFirst [

	| select result |

	conn execute: 'INSERT INTO student(id) VALUES (1)'.
	conn execute: 'INSERT INTO student(id) VALUES (2)'.
	conn execute: 'INSERT INTO signature(code, name, observations, id_student) VALUES (59, ''TADP'', ''Tecnicas Av'', 1)'.
	conn execute: 'INSERT INTO signature(code, name, observations, id_student) VALUES (59, ''TADP'', ''Tecnicas Av'', 2)'.
	select:= 'SELECT code, name, observations, id_student FROM signature'.

	result := conn execute: select.
	self assert: (result first atIndex: 4) equals: 1.
]

{ #category : #'as yet unclassified' }
GAQueryTest >> testResultIterateSelect [

	| select result selected |

	conn execute: 'INSERT INTO student(id) VALUES (1)'.
	conn execute: 'INSERT INTO student(id) VALUES (2)'.
	conn execute: 'INSERT INTO signature(code, name, observations, id_student) VALUES (59, ''TADP'', ''Tecnicas Av'', 1)'.
	conn execute: 'INSERT INTO signature(code, name, observations, id_student) VALUES (59, ''TADP'', ''Tecnicas Av'', 2)'.
	select:= 'SELECT code, name, observations, id_student FROM signature'.

	result := conn execute: select.
	selected := result select: [ :row | (row atIndex: 4) = 2].

	self assert: selected size equals: 1.
]

{ #category : #'as yet unclassified' }
GAQueryTest >> testResultIterateStream [

	| select result row rows |

	conn execute: 'INSERT INTO student(id) VALUES (1)'.
	conn execute: 'INSERT INTO student(id) VALUES (2)'.
	conn execute: 'INSERT INTO signature(code, name, observations, id_student) VALUES (59, ''TADP'', ''Tecnicas Av'', 1)'.
	conn execute: 'INSERT INTO signature(code, name, observations, id_student) VALUES (59, ''TADP'', ''Tecnicas Av'', 2)'.
	select:= 'SELECT code, name, observations FROM signature'.

	result := (conn execute: select) readStream.
	rows := 0.
	[ (row := result next) notNil ] whileTrue: [
		self assert: (row at: 1) equals: 59.
		self assert: (row at: 2) equals: 'TADP'.
		self assert: (row at: 3) equals: 'Tecnicas Av'. 
		rows := rows + 1. ].

	self assert: rows equals: 2.
]

{ #category : #'as yet unclassified' }
GAQueryTest >> testResultIterateStreamNextColonIsNilWhenEmpty [

	| select result |

	conn execute: 'INSERT INTO student(id) VALUES (1)'.
	conn execute: 'INSERT INTO student(id) VALUES (2)'.
	conn execute: 'INSERT INTO signature(code, name, observations, id_student) VALUES (59, ''TADP'', ''Tecnicas Av'', 1)'.
	conn execute: 'INSERT INTO signature(code, name, observations, id_student) VALUES (59, ''TADP'', ''Tecnicas Av'', 2)'.
	select:= 'SELECT code, name, observations FROM signature'.

	result := (conn execute: select) readStream.
	result next: 2.
	
	self assert: (result next: 1) equals: #()
]

{ #category : #'as yet unclassified' }
GAQueryTest >> testResultIterateStreamNextColonReturnsOnlyWhatItHas [

	| select result |

	conn execute: 'INSERT INTO student(id) VALUES (1)'.
	conn execute: 'INSERT INTO student(id) VALUES (2)'.
	conn execute: 'INSERT INTO signature(code, name, observations, id_student) VALUES (59, ''TADP'', ''Tecnicas Av'', 1)'.
	conn execute: 'INSERT INTO signature(code, name, observations, id_student) VALUES (59, ''TADP'', ''Tecnicas Av'', 2)'.
	select:= 'SELECT code, name, observations FROM signature'.

	result := (conn execute: select) readStream.
	self assert: (result next: 3) size equals: 2.
]

{ #category : #'as yet unclassified' }
GAQueryTest >> testResultIterateStreamNextIsNilWhenEmpty [

	| select result |

	conn execute: 'INSERT INTO student(id) VALUES (1)'.
	conn execute: 'INSERT INTO student(id) VALUES (2)'.
	conn execute: 'INSERT INTO signature(code, name, observations, id_student) VALUES (59, ''TADP'', ''Tecnicas Av'', 1)'.
	conn execute: 'INSERT INTO signature(code, name, observations, id_student) VALUES (59, ''TADP'', ''Tecnicas Av'', 2)'.
	select:= 'SELECT code, name, observations FROM signature'.

	result := (conn execute: select) readStream.
	result next: 2.
	
	self assert: result next isNil
]

{ #category : #'as yet unclassified' }
GAQueryTest >> testResultIterateStreamNextN [

	| select result rows |

	conn execute: 'INSERT INTO student(id) VALUES (1)'.
	conn execute: 'INSERT INTO student(id) VALUES (2)'.
	conn execute: 'INSERT INTO signature(code, name, observations, id_student) VALUES (59, ''TADP'', ''Tecnicas Av'', 1)'.
	conn execute: 'INSERT INTO signature(code, name, observations, id_student) VALUES (59, ''TADP'', ''Tecnicas Av'', 2)'.
	select:= 'SELECT code, name, observations FROM signature'.

	result := (conn execute: select) readStream.
	rows := result next: 1.
	
	self assert: rows size equals: 1.
	self assert: (rows first at: 1) equals: 59.
	self assert: (rows first at: 2) equals: 'TADP'.
	self assert: (rows first at: 3) equals: 'Tecnicas Av'. 
	
	rows := result next: 1.
	self assert: rows size equals: 1.
	self assert: (rows first at: 1) equals: 59.
	self assert: (rows first at: 2) equals: 'TADP'.
	self assert: (rows first at: 3) equals: 'Tecnicas Av'. 
]

{ #category : #'as yet unclassified' }
GAQueryTest >> testResultOfDDL [
	
	| result |
	result := conn execute: 'CREATE TABLE CATS (
		name varchar(50),
		owner varchar(50))'.

	self assert: result affectedRows = 0.
]

{ #category : #'as yet unclassified' }
GAQueryTest >> testResultOfDelete [
	
	| result |
	conn execute: 'CREATE TABLE CATS (
		name varchar(50),
		owner varchar(50))'.

	conn execute: 'INSERT INTO CATS(name,owner) VALUES(''lutz'',''julien'')'.
	conn execute: 'INSERT INTO CATS(name,owner) VALUES(''camila'',''guille'')'.
	conn execute: 'INSERT INTO CATS(name,owner) VALUES(''inuk'',''victor'')'.
	
	result := conn execute: 'DELETE FROM CATS'.

	self assert: result affectedRows = 3.
]

{ #category : #'as yet unclassified' }
GAQueryTest >> testResultOfDeleteWhere [
	
	| result |
	conn execute: 'CREATE TABLE CATS (
		name varchar(50),
		owner varchar(50))'.

	conn execute: 'INSERT INTO CATS(name,owner) VALUES(''lutz'',''julien'')'.
	conn execute: 'INSERT INTO CATS(name,owner) VALUES(''camila'',''guille'')'.
	conn execute: 'INSERT INTO CATS(name,owner) VALUES(''inuk'',''victor'')'.
	
	result := conn execute: 'DELETE FROM CATS WHERE name != ''lutz'''.

	self assert: result affectedRows = 2.
]

{ #category : #'as yet unclassified' }
GAQueryTest >> testResultOfInsert [
	
	| result |
	conn execute: 'CREATE TABLE CATS (
		name varchar(50),
		owner varchar(50))'.

	result := conn execute: 'INSERT INTO CATS(name,owner) VALUES(''lutz'',''julien'')'.

	self assert: result affectedRows = 1.
]

{ #category : #'as yet unclassified' }
GAQueryTest >> testResultOfUpdate [
	
	| result |
	conn execute: 'CREATE TABLE CATS (
		name varchar(50),
		owner varchar(50))'.

	conn execute: 'INSERT INTO CATS(name,owner) VALUES(''lutz'',''julien'')'.
	conn execute: 'INSERT INTO CATS(name,owner) VALUES(''camila'',''guille'')'.
	conn execute: 'INSERT INTO CATS(name,owner) VALUES(''inuk'',''victor'')'.
	
	result := conn execute: 'UPDATE CATS SET owner=''guille'''.

	"Mysql only affects rows that he has to update"
	conn affectsOnlyChangedRows ifTrue: [ 
		self assert: result affectedRows = 2.
	] ifFalse: [ 
		self assert: result affectedRows = 3.
	]
]

{ #category : #'as yet unclassified' }
GAQueryTest >> testResultOfUpdateWhere [
	
	| result |
	conn execute: 'CREATE TABLE CATS (
		name varchar(50),
		owner varchar(50))'.

	conn execute: 'INSERT INTO CATS(name,owner) VALUES(''lutz'',''julien'')'.
	conn execute: 'INSERT INTO CATS(name,owner) VALUES(''camila'',''guille'')'.
	conn execute: 'INSERT INTO CATS(name,owner) VALUES(''inuk'',''victor'')'.
	
	result := conn execute: 'UPDATE CATS SET owner = ''guille'' WHERE owner != ''guille'''.

	self assert: result affectedRows = 2.
]
