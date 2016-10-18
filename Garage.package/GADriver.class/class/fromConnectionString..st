instance-creation
fromConnectionString: string
	
	| connectionString |
	string isString ifTrue: [connectionString := GAConnectionString fromString: string]
		ifFalse: [ connectionString := string ].
	^ (self driverAt: connectionString driverId) fromConnectionString: connectionString