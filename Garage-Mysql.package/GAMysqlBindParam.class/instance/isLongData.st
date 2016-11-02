testing
isLongData
	| typeRange |
	"We also send varchar types as long data"
	self paramType = GAMysqlTypes typeVARCHAR ifTrue: [^ true].
	typeRange := (GAMysqlTypes typeTINYBLOB to: GAMysqlTypes typeSTRING).
	^ typeRange includes: self paramType 
	