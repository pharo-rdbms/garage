execute
prepare
	| cmd |
	cmd := GAMysqlCommand new.
	cmd command: self commandCode arg: self commandArg.
	^ cmd