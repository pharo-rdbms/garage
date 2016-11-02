connection
authenticate

	| auth response |
	handshakeInfo := GAMysqlHandshake from: netSession read.
	handshakeInfo supportsProtocol41 
		ifFalse: [ GAMysqlUnsupportedProtocolError signal: 'Server does not support protocol version 41' ].
	
	auth := GAMysqlClientAuth new
		serverCaps: handshakeInfo serverCaps;
		charset: handshakeInfo serverLang;
		user: self user;
		password: self password;
		database: self database;
		scrambleBuff: handshakeInfo scrambleBuff ;
		scrambleBuffMore: handshakeInfo scrambleBuffMore;
		yourself.
	netSession write: auth write.
	response := self peekPacket.
	
	response isEof ifTrue: [ | scrmblPkt |
		"Read the send short hash indicator: sinsgle eof(254) byte)"
		GAMysqlPacket from: netSession read.
		"This is an indication that comes from server if the password for this user
		follows the old style (short hash) instead of the new style (long hash). 
		We need to send back the 323 scramble"
		scrmblPkt := GAMysql323Scramble new.
		scrmblPkt password: self password; scrambleBuff: handshakeInfo scrambleBuff.
		netSession write: scrmblPkt write.
		response := self peekPacket ].
	^ response