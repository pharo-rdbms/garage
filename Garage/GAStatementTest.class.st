Class {
	#name : #GAStatementTest,
	#superclass : #GADriverTest,
	#category : 'Garage-Tests'
}

{ #category : #'as yet unclassified' }
GAStatementTest >> testCreateStatement [

	| statementString statement |
	statementString := 'CREATE TABLE CATS (
	name varchar(50),
	owner varchar(50))'.
	statement := conn createStatement: statementString.
	
	self assert: statement notNil.
	self assert: statement statementString equals: statementString.
]

{ #category : #'as yet unclassified' }
GAStatementTest >> testCreateStatementWithoutStatementString [

	| statementString statement |
	statementString := 'CREATE TABLE CATS (
	name varchar(50),
	owner varchar(50))'.
	statement := conn createStatement.
	statement statementString: statementString.	

	self assert: statement notNil.
	self assert: statement statementString equals: statementString.
]

{ #category : #'as yet unclassified' }
GAStatementTest >> testExecuteStatement [

	| statement result |
	conn execute: 'CREATE TABLE CATS (
	name varchar(50),
	owner varchar(50))'.

	conn execute: 'INSERT INTO CATS(name, owner) VALUES(''lutz'', ''julien'')'.
	statement := conn createStatement: 'SELECT * FROM CATS'.
	result := statement execute.

	self assert: (result first at: 1) equals: 'lutz'.
	self assert: (result first at: 2) equals: 'julien'.
]

{ #category : #'as yet unclassified' }
GAStatementTest >> testExecuteStatementTwice [

	| statement result |
	conn execute: 'CREATE TABLE CATS (
	name varchar(50),
	owner varchar(50))'.

	conn execute: 'INSERT INTO CATS(name, owner) VALUES(''lutz'', ''julien'')'.
	statement := conn createStatement: 'SELECT * FROM CATS'.
	result := statement execute.

	self assert: (result first at: 1) equals: 'lutz'.
	self assert: (result first at: 2) equals: 'julien'.
	
	result := statement execute.

	self assert: (result first at: 1) equals: 'lutz'.
	self assert: (result first at: 2) equals: 'julien'.
]

{ #category : #'as yet unclassified' }
GAStatementTest >> testStatementDoesNotAcceptBindings [

	| statementString statement |
	statementString := 'CREATE TABLE CATS (
	name varchar(50),
	owner varchar(50))'.
	statement := conn createStatement: statementString.
	
	self should: [ statement at: 1 bind: 'unbinded' ] raise: Error.
]
