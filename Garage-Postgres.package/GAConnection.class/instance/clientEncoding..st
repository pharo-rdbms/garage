as yet unclassified
clientEncoding: aSymbol

	sqlStringConverter := [ :sqlString | 
		sqlString convertToEncoding: aSymbol ].
	receivingTextConverter := TextConverter newForEncoding: aSymbol.
	#(25 1043) do: [ 	:each | 
		self fieldConverters  at: each put: [ :s | 
			s convertFromWithConverter: receivingTextConverter ] ].	
