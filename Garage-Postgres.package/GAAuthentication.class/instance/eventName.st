accessing
eventName

	type > 6 ifTrue: [self error: 'Unknown authentication type'].

	^#(
		AuthenticationOk
		AuthenticationKerberosV4
		AuthenticationKerberosV5
		AuthenticationCleartextPassword
		AuthenticationCryptPassword
		AuthenticationMD5Password
		AuthenticationSCMCredential
	) at: (type + 1)
