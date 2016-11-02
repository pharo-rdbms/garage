integer
longIntFrom: aStream
	^ aStream next + (aStream next << 8) + (aStream next << 16) + (aStream next << 24)
	