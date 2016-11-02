real
decimalWithScale: scale from: aStream
	| valueString |
	valueString := (GAMysqlHelper decodeLcsFrom: aStream) asString, 's', scale asString.
	^ valueString asNumber
	