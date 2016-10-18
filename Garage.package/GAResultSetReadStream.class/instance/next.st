accessing
next
	
	"Advances the stream and retrieves the row at the current position. If no more rows are available, it returns nil."
	position := position + 1.
	^ self currentRow.