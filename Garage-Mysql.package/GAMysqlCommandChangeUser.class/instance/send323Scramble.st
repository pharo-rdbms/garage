as yet unclassified
send323Scramble
	| scrmblPkt |
	scrmblPkt := GAMysql323Scramble new.
	scrmblPkt password: password; scrambleBuff: scrambleBuff.
	self send: scrmblPkt
	