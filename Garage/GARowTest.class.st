Class {
	#name : #GARowTest,
	#superclass : #GADriverTest,
	#category : 'Garage-Tests'
}

{ #category : #'as yet unclassified' }
GARowTest >> testAccessFirst [
	" self debug: #testCursoredResult "
	| result  |

	conn execute: 'CREATE TABLE CATS (
		name varchar(50),
		owner varchar(50))'.

	conn execute: 'INSERT INTO CATS(name,owner) VALUES(''lutz'',''julien'')'.

	result := conn execute: 'SELECT * FROM CATS'.

	self assert: result first first equals: 'lutz'.
]

{ #category : #'as yet unclassified' }
GARowTest >> testAccessLast [
	" self debug: #testCursoredResult "
	| result  |

	conn execute: 'CREATE TABLE CATS (
		name varchar(50),
		owner varchar(50))'.

	conn execute: 'INSERT INTO CATS(name,owner) VALUES(''lutz'',''julien'')'.

	result := conn execute: 'SELECT * FROM CATS'.

	self assert: result first last equals: 'julien'.
]

{ #category : #'as yet unclassified' }
GARowTest >> testAccessRowByIndex [
	" self debug: #testCursoredResult "
	| result catRow |

	conn execute: 'CREATE TABLE CATS (
		name varchar(50),
		owner varchar(50))'.

	conn execute: 'INSERT INTO CATS(name,owner) VALUES(''lutz'',''julien'')'.

	result := conn execute: 'SELECT name AS catname, owner FROM CATS'.
	catRow := result first.

	self assert: (catRow atIndex: 1) equals: 'lutz'.
	self assert: (catRow atIndex: 2) equals: 'julien'.
]

{ #category : #'as yet unclassified' }
GARowTest >> testAccessRowByNameString [
	" self debug: #testCursoredResult "
	| result catRow |

	conn execute: 'CREATE TABLE CATS (
		name varchar(50),
		owner varchar(50))'.

	conn execute: 'INSERT INTO CATS(name,owner) VALUES(''lutz'',''julien'')'.

	result := conn execute: 'SELECT name AS catname, owner FROM CATS'.
	catRow := result first.

	self assert: (catRow atName: 'catname') equals: 'lutz'.
	self assert: (catRow atName: 'owner') equals: 'julien'.
]

{ #category : #'as yet unclassified' }
GARowTest >> testAccessRowByNameSymbol [
	" self debug: #testCursoredResult "
	| result catRow |

	conn execute: 'CREATE TABLE CATS (
		name varchar(50),
		owner varchar(50))'.

	conn execute: 'INSERT INTO CATS(name,owner) VALUES(''lutz'',''julien'')'.

	result := conn execute: 'SELECT name AS catname, owner FROM CATS'.
	catRow := result first.

	self assert: (catRow atName: #catname) equals: 'lutz'.
	self assert: (catRow atName: #owner) equals: 'julien'.
]

{ #category : #'as yet unclassified' }
GARowTest >> testAccessUnamedFunctionsByName [
	" self debug: #testCursoredResult "
	| result  |

	conn execute: 'CREATE TABLE CATS (
		name varchar(50),
		owner varchar(50))'.

	conn execute: 'INSERT INTO CATS(name,owner) VALUES(''lutz'',''julien'')'.

	result := conn execute: 'SELECT COUNT(*) AS count FROM CATS'.

	self assert: (result first atName: 'count') equals: 1.
]
