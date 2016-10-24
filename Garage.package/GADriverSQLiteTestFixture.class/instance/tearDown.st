as yet unclassified
tearDown

	setupConnection ifNotNilDo: #close.
	setupConnection := nil.