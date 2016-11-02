as yet unclassified
onSession: ioSession driver: aDriver
	^ self new
		session: ioSession;
		driver: aDriver;
		yourself