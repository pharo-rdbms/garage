as yet unclassified
parse
	catalog := (self decodeLcsFrom: inStream) asString.
	db := (self decodeLcsFrom: inStream) asString.
	table := (self decodeLcsFrom: inStream) asString.
	orgTable := (self decodeLcsFrom: inStream) asString.
	name := (self decodeLcsFrom: inStream) asString.
	orgName := (self decodeLcsFrom: inStream) asString.
	inStream next. "filler"
	charSet := inStream next + (inStream next bitShift: 8).
	length := inStream next + (inStream next bitShift: 8) + 
		(inStream next bitShift: 16) + (inStream next bitShift: 24).
	type := inStream next.
	flags := inStream next + (inStream next bitShift: 8).
	decimals := inStream next.
	inStream next; next. "2 filler"
	"The field default only appears for table definitions, not for normal resultsets"
	inStream atEnd ifFalse: [default := self decodeLcbFrom: inStream].
	