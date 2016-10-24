accessing-convenience
dataRows

	^ self lastResultSet ifNotNilDo: [ :rs |
		rs dataRows ]