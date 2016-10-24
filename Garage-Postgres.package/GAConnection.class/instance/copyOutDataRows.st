private-actions
copyOutDataRows

	| ch lf notDone pch ppch |
	lf := Character lf.
	notDone := true.
	pch := $x.
	ch := $x.
	[notDone] whileTrue: [
		ppch := pch.
		pch := ch.
		ch := self next.
		copyStream nextPut: ch.
		((ch = lf and: [pch = $.]) and: [ppch = $\])
			ifTrue: [notDone := false].
	].

