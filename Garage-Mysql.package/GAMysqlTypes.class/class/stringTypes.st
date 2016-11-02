as yet unclassified
stringTypes
	stringTypes ifNil: [
		stringTypes := Array with: TypeSTRING with: TypeVARCHAR with: TypeVARSTRING ].
	^ stringTypes
	