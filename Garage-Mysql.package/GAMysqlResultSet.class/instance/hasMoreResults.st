testing
hasMoreResults
	"Looks like the flag, when set, will be set by the server in both the
	field eof and rowdata eof packets. We are only using field eof here, since
	rowdata eof may not sometimes sent as part of the result set (e.g., cursor)."
	^ fieldsEof hasMoreResults
	