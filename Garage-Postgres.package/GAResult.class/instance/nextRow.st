accessing
nextRow

	self rows ifEmpty:[ ^ nil ].
	^ self rows removeFirst