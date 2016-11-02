accessing
detectParamSign
	"true is unsigned, false if signed"
	^ (((paramValue isKindOf: Number) or: [paramValue isKindOf: Duration]) and: [paramValue negative]) not
	