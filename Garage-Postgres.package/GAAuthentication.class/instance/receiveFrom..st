receiving
receiveFrom: connection

	type := self readInt32From: connection.

	"AuthenticationCryptPassword"
	type == 4 ifTrue: [ salt := self readByteN: 2 from: connection ].

	"AuthenticationMD5Password"
	type == 5 ifTrue: [ salt := self readByteN: 4 from: connection ].

	"
	For documentation purposes here are the other authentication methods.
	There is no other packet data to read in these cases.

	type == 1 AuthenticationKerberosV4
	type == 2 AuthenticationKerberosV5
	type == 3 AuthenticationCleartextPassword
	type == 6 AuthenticationSCMCredential
	"
