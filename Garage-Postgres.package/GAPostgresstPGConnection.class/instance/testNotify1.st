tests
testNotify1

	SystemVersion current major >= 7 ifTrue: [ self timeLimit: 1 minute ].
	notificationSubscriberCount := 1.

	[
		self executeAll: #(
			'notify pgtest' 'notify pgtest' 'notify pgtest' 'notify pgtest' 'notify pgtest'
			'notify pgtest' 'notify pgtest' 'notify pgtest' 'notify pgtest' 'notify pgtest'
		) withDelayForMilliseconds: 1000
	] fork.

	self executeAll: #(
		'listen pgtest'
		'select timenow()'
		'select timenow()'
	) withDelayForMilliseconds: 5000
