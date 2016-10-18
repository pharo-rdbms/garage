public API
with: aStatement at: aColumn putString: aString
	^ self apiBindString: aStatement atColumn: aColumn with: (self pharoStringToUTF8: aString) with: -1 with: -1 