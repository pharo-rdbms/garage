initialize - release
initialize

	super initialize.
	name := 'cursorpgv2', UUID new asString36.
	rows := OrderedCollection new.
	finished := false.
	