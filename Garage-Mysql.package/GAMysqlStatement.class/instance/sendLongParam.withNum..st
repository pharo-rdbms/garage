private
sendLongParam: aParam withNum: paramNum
	| cmd dataStream dataPart |
	
	dataStream := ReadStream on: aParam stringOrBlobBytesRaw.
	[
		dataPart := dataStream next: 1048576. "1 MB; default"
		cmd := GAMysqlCommandSendLongData onSession: connection netSession driver: connection.
		cmd 
			paramNum: paramNum;
			statementId: stmtId; 
			dataBytes: dataPart.
		cmd execute] doWhileFalse: [dataStream atEnd]
	