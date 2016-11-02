accessing
bindValue: aValue 
	| boundType |
	paramValue := aValue.
	(boundType := self detectParamType) ~= paramType 
		ifTrue: [
			paramType := boundType.
			newParamBound := true].
	GAMysqlTypes typeVARSTRING = paramType ifTrue: [ paramValue := connection encoder encodeString: paramValue ].
	unsignedFlag := self detectParamSign.
	