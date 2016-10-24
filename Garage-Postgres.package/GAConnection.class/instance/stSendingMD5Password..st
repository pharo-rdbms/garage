private-states
stSendingMD5Password: event 
	"MD5 authentication as explain in http://archives.postgresql.org/pgsql-novice/2003-05/msg00305.php"
	| hashedCredentials hashedMessage |

	hashedCredentials := (MD5 hashMessage: (connectionArgs password, connectionArgs userName)) hex asLowercase.
	hashedMessage := 'md5', (MD5 hashMessage: (hashedCredentials, event salt asString)) hex asLowercase.

	self	sendPacket: (GAPasswordPacket password: hashedMessage) on: socket.
