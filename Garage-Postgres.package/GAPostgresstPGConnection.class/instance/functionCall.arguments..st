private
functionCall: oid arguments: arguments

	| conn result |
	conn := self newConnection.
	conn startup.
	result := conn functionCall: oid arguments: arguments.
	conn terminate.
	^ result
