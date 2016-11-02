as yet unclassified
parse 
	inStream next.	"always 0, marker for oaky pakcet"
	stmtId := inStream next + (inStream next bitShift: 8) + 
			(inStream next bitShift: 16) + (inStream next bitShift: 24).
	numColumns := inStream next + (inStream next bitShift: 8).
	numParams := inStream next + (inStream next bitShift: 8).
	inStream next.	"filler, always 0"
	warningCount := inStream next + (inStream next bitShift: 8)
	