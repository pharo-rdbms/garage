accessing
propertyAt: aKey

	"Obtains the property set at a key"
	^ self propertyAt: aKey ifAbsent: [ self error: 'unexistent key: ', aKey ]