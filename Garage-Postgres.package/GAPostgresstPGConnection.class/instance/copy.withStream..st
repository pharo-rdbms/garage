private
copy: sql withStream: aStream

	| conn |
	conn := self newConnection.
	conn startup.
	conn copy: sql withStream: aStream.
	conn terminate.