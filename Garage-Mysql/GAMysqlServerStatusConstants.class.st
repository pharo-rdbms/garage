Class {
	#name : #GAMysqlServerStatusConstants,
	#superclass : #Object,
	#classVars : [
		'ServerMoreResultsExist',
		'ServerQueryNoGoodIndexUsed',
		'ServerQueryNoIndexUsed',
		'ServerStatusAutoCommit',
		'ServerStatusCursorExists',
		'ServerStatusDbDropped',
		'ServerStatusInTranssaction',
		'ServerStatusLastRowSent',
		'ServerStatusNoBackslashEscapes'
	],
	#category : 'Garage-MySQL-Protocol'
}

{ #category : #'as yet unclassified' }
GAMysqlServerStatusConstants class >> initFlags [
	ServerStatusInTranssaction := 1. 		"transaction has started"
	ServerStatusAutoCommit := 2. 		"in autocommit mode"
	ServerMoreResultsExist := 8.			"multiple result sets for multi-query"
	ServerQueryNoGoodIndexUsed := 16.
	ServerQueryNoIndexUsed := 32.
	
	"The server was able to fulfill the clients request and opened a
	read-only non-scrollable cursor for a query. This flag comes
	in reply to COM_STMT_EXECUTE and COM_STMT_FETCH commands."
	ServerStatusCursorExists := 64.
	
	"This flag is sent when a read-only cursor is exhausted, in reply to
	COM_STMT_FETCH command."
	ServerStatusLastRowSent := 128.
	ServerStatusDbDropped := 256. 		"a database was dropped"
	ServerStatusNoBackslashEscapes := 512.
	
]

{ #category : #'as yet unclassified' }
GAMysqlServerStatusConstants class >> initialize [
	"self initialize"
	self initFlags.
	
]

{ #category : #'as yet unclassified' }
GAMysqlServerStatusConstants class >> moreResultsExist [
	^ ServerMoreResultsExist
	
]

{ #category : #'as yet unclassified' }
GAMysqlServerStatusConstants class >> statusAutoCommit [
	^ ServerStatusAutoCommit
]

{ #category : #'as yet unclassified' }
GAMysqlServerStatusConstants class >> statusCursorExists [
	^ ServerStatusCursorExists
	
]

{ #category : #'as yet unclassified' }
GAMysqlServerStatusConstants class >> statusInTransaction [
	^ ServerStatusInTranssaction
]

{ #category : #'as yet unclassified' }
GAMysqlServerStatusConstants class >> statusLastRowSent [
	^ ServerStatusLastRowSent
	
]

{ #category : #'as yet unclassified' }
GAMysqlServerStatusConstants class >> statusNoIndexUsed [
	^ ServerQueryNoIndexUsed
]
