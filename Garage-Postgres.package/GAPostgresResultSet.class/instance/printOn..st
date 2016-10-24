printing
printOn: aStream
	super printOn: aStream.
	aStream
		<< '(';
		cr.
	self displayResultSetOn: aStream.
	aStream << ')'