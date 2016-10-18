as yet unclassified
at: aColumn bind: anObject

	| result |
	result := self basicBind: aColumn toObject: anObject.
	GASqlite3FFI current checkForOk: result on: connection handle.