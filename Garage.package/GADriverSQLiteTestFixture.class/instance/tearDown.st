as yet unclassified
tearDown

	setupConnection ifNotNil: #close.
	setupConnection := nil.