printing
displayResultSetOn: aStream

	completedResponse ifNotNil: [
		completedResponse displayOn: aStream.
		aStream cr.
	].
	rowDescription ifNotNil: [
		self displayRowDescriptionOn: aStream.
		aStream cr; nextPutAll: '----------'; cr.
		self displayRowsOn: aStream.
		aStream nextPut: $(.
		rows size printOn: aStream.
		aStream nextPutAll: ' row'.
		rows size > 1 ifTrue: [aStream nextPut: $s].
		aStream nextPut: $); cr; cr.
	].
