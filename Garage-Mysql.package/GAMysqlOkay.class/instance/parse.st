as yet unclassified
parse 
	fieldCount := self decodeLcbFrom: inStream . "always 0"
	affectedRows := self decodeLcbFrom: inStream .
	insertId := self decodeLcbFrom: inStream .
	serverStatus := inStream next + (inStream next bitShift: 8) .
	warningCount := inStream next + (inStream next bitShift: 8) .
	message := (inStream upToEnd) asString.
	