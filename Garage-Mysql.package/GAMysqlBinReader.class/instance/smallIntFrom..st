integer
smallIntFrom: aStream
	^ aStream next + (aStream next << 8) 
		