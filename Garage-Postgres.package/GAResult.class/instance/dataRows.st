accessing-convenience
dataRows

	^ self lastResultSet ifNotNil: [ :rs |
		rs dataRows ]