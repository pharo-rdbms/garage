reading
readFrom: aStream
	length := aStream next + (aStream next << 8) + (aStream next << 16).
	number := aStream next.
	data := aStream next: length.