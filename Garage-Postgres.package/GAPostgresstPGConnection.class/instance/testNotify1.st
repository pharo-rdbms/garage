tests
testNotify1

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
