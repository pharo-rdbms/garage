Class {
	#name : #GATransactionTest,
	#superclass : #GADriverTest,
	#category : 'Garage-Tests'
}

{ #category : #'as yet unclassified' }
GATransactionTest >> testAutocommit [
	
	self assert: conn hasAutoCommit equals: conn defaultValueAutoCommit
]

{ #category : #'as yet unclassified' }
GATransactionTest >> testCommit [
	| result row  |

	conn beginTransaction.
	conn execute: 'INSERT INTO student(id) VALUES (1)'.
	conn execute: 'INSERT INTO signature(code, name, observations, id_student) VALUES (59, ''TADP'', ''Tecnicas Av'', 1)'.
	result := conn execute: 'SELECT code, name, observations, id_student FROM signature'.
	row := result first.
	
	self assert: (row at: 1) equals: 59.
	self assert: (row at: 2) equals: 'TADP'.
	self assert: (row at: 3) equals: 'Tecnicas Av'.
	self assert: (row at: 4) equals: 1.
	
	conn commitTransaction.
	
	result := conn execute: 'SELECT code, name, observations, id_student FROM signature'.
	row := result first.
	
	self assert: (row at: 1) equals: 59.
	self assert: (row at: 2) equals: 'TADP'.
	self assert: (row at: 3) equals: 'Tecnicas Av'.
	self assert: (row at: 4) equals: 1.
]

{ #category : #'as yet unclassified' }
GATransactionTest >> testRollback [
	| result row |
	"self debug: #testRollback"

	conn beginTransaction.
	conn execute: 'INSERT INTO student(id) VALUES (1)'.
	conn execute: 'INSERT INTO signature(code, name, observations, id_student) VALUES (59, ''TADP'', ''Tecnicas Av'', 1)'.
	
	result := conn execute: 'SELECT code, name, observations, id_student FROM signature'.
	row := result first.
	
	self assert: (row at: 1) equals: 59.
	self assert: (row at: 2) equals: 'TADP'.
	self assert: (row at: 3) equals: 'Tecnicas Av'.
	self assert: (row at: 4) equals: 1.
	
	conn rollbackTransaction.
	
	result := conn execute: 'SELECT code, name, observations, id_student FROM signature'.
	self assert: result isEmpty.
]
