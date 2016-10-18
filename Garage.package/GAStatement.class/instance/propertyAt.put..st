accessing
propertyAt: aKey put: aValue

	"Sets the property with the given key with the given value"
	properties ifNil: [ properties := Dictionary new ].
	properties at: aKey put: aValue