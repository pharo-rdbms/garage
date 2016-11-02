time
timeStampFrom: aStream "ByteStream"
	| dt |
	dt := self dateTimeFrom: aStream.
	^ dt ifNil: [nil] ifNotNil: [dt asTimeStamp]
	