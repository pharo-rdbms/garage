integer
bigIntFrom: aStream
	^ aStream next + (aStream next << 8) + (aStream next << 16) + (aStream next << 24) + 
		(aStream next << 32) + (aStream next << 40) + (aStream next << 48) + (aStream next << 56)
		