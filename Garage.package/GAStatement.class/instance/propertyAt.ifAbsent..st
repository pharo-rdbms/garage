accessing
propertyAt: aKey ifAbsent: aBlock

	"Obtains the property set at a key. If absent, aBlock is executed."
	properties ifNil: [ ^ aBlock value ].
	^ properties at: aKey ifAbsent: aBlock