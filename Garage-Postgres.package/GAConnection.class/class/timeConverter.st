converters
timeConverter 

	^[ :s | Time readFrom: (ReadStream on: s) ]