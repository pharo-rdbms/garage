as yet unclassified
write
	| flags scrmbl buffStream maxNetPacketLength |
	buffStream := WriteStream on: (ByteArray new: 1024).
	flags := serverCaps bitAnd: clientCaps.
	flags := flags bitOr: CapMultiStatements + CapMultiResults.
	buffStream
		nextPut: (flags digitAt: 1);
		nextPut: (flags digitAt: 2);
		nextPut: (flags digitAt: 3);
		nextPut: (flags digitAt: 4).
	maxNetPacketLength := self class maxNetPacketLength.
	buffStream
		nextPut: (maxNetPacketLength digitAt: 1);
		nextPut: (maxNetPacketLength digitAt: 2);
		nextPut: (maxNetPacketLength digitAt: 3);
		nextPut: (maxNetPacketLength digitAt: 4).
	buffStream nextPut: (charset digitAt: 1).
	buffStream nextPutAll: (ByteArray 
			new: 23
			withAll: 0).	"filler"
	buffStream nextPutAll: user asByteArray.
	buffStream nextPut: 0.	"null terminated"
	scrmbl := password isEmptyOrNil 
		ifTrue: [ '' asByteArray ]
		ifFalse: 
			[ GAMysqlHelper 
				secureScramble: scrambleBuff , scrambleBuffMore
				with: password ].
	self 
		encodeLcs: scrmbl
		on: buffStream.
	
	((flags bitAnd: CapConnectWithDb) = CapConnectWithDb) ifTrue: [
		database isEmptyOrNil not ifTrue: [
			buffStream nextPutAll: database asByteArray].
		buffStream nextPut: 0	"null terminated" ].
	
	^ buffStream contents