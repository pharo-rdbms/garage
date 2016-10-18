factory
current
	^ Singleton ifNil: [ Singleton := self basicNew ]