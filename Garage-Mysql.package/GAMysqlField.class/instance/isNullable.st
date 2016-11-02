as yet unclassified
isNullable
	^ (flags bitAnd: NotNullFlag) ~= NotNullFlag  
	