as yet unclassified
parse
	fieldCount := inStream next. "always 0xFF"
	errNo := inStream next + (inStream next bitShift: 8).	
	sqlStateMarker := inStream next asCharacter. "always #"
	sqlState := (inStream next: 5) asString .
	message := inStream upToEnd asString.
