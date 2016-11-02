as yet unclassified
write
	| scrmbl buffStream |
	buffStream := WriteStream on: (ByteArray new: 256).
	scrmbl := password isEmptyOrNil 
		ifTrue: [ '' asByteArray ]
		ifFalse: 	[ 
			GAMysqlHelper 
				scramble323: scrambleBuff
				with: password ].
	"Server expects just the scramble, null terminated and nothing else"
	buffStream nextPutAll: scrmbl.
	buffStream nextPut: 0.
	^ buffStream contents 
	