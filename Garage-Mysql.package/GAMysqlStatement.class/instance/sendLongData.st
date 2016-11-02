as yet unclassified
sendLongData

	params keysAndValuesDo: [ :indx :aParam |
		aParam isLongData ifTrue: [
			self sendLongParam: aParam withNum: indx - 1. "first param index is 0"
			aParam sentAsLongData: true "mark that it has been sent as long data"]]
	