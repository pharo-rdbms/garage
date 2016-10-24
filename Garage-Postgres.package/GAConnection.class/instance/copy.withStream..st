api
copy: copySql withStream: aStream

	"The syntax of a COPY command is:

	COPY [ BINARY ] table [ WITH OIDS ]
		FROM { 'filename' | stdin }
		[ [USING] DELIMITERS 'delimiter' ]
		[ WITH NULL AS 'null string' ]

	COPY [ BINARY ] table [ WITH OIDS ]
		TO { 'filename' | stdout }
		[ [USING] DELIMITERS 'delimiter' ]
		[ WITH NULL AS 'null string' ]

	The 'stdin' or 'stdout' option must be used, not the 'filename' option.
	'aStream' will supply the COPY...FROM input.
	'aStream' will received the COPY...TO output.
	"

	sql := copySql.
	copyStream := aStream.
	self queueEvent: #Query.
	self saProcessEventsUntil: #(ReadyForQuery ConnectionFailed).
	^ result
