writing
writePacketData: data 
	| pkt nextPktStart dataLen |
	
	nextPktStart := 1.
	dataLen := data size.
	[	pkt := GAMysqlNetPacket new.
		pkt length: (dataLen min: pkt maxLength);
			number: self getSequence;
			data: (data copyFrom: nextPktStart  to: (nextPktStart + pkt length - 1)).
			
		self updateSequence.
		dataLen := dataLen - pkt length.
		nextPktStart := nextPktStart + pkt length.
		
		self writeNetPacket: pkt
	] doWhileTrue: [ pkt isOfMaxLength ]