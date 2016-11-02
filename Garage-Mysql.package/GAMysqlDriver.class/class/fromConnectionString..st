instance-creation
fromConnectionString: aConnectionString
	
	| connection |
	connection := self new.
	connection connectionString: aConnectionString.
	connection host: aConnectionString host.
	connection port: aConnectionString port asInteger.
	connection database: aConnectionString database.
	connection user: aConnectionString user.
	connection password: aConnectionString password.
	^ connection