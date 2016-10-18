as yet unclassified
testPrepareWithUnboundArgsWithDriversThatChooseADefault
	| preparedStatement |
	conn supportsPreparedStatements ifFalse: [ ^self skip ].
	conn notBoundArgumentsFail ifTrue: [ ^self skip ].
	"Not bound arguments are taken as NULL"
	
	preparedStatement := conn prepare: 'INSERT INTO signature(code, name, observations, id_student) VALUES (59, ''TADP'', ''Tecnicas Av'', ?)'.
	preparedStatement execute.
	
	(conn execute: 'SELECT id_student FROM signature') do: [ :r | self assert: (r at: 1) isNil ]