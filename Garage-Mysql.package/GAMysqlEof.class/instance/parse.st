as yet unclassified
parse
	fieldCount := inStream next.
	warningCount := inStream next + (inStream next bitShift: 8).
	serverStatus := inStream next + (inStream next bitShift: 8).
