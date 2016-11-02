as yet unclassified
initialize
	"self initialize"
	
	ComSleep := 16r00.
	ComQuit := 16r01.
	ComInitDb := 16r02.
	ComQuery := 16r03.
	ComFieldList := 16r04.
	ComStat := 16r09.
	ComDebug := 16r0D.
	ComPing := 16r0E.
	ComChangeUser := 16r11.
	ComStmtPrepare := 16r16.
	ComStmtExecute := 16r17.
	ComStmtSendLongData := 16r18.
	ComStmtClose := 16r19.
	ComStmtReset := 16r1A.
	ComSetOption := 16r1B.
	ComStmtFetch := 16r1C.