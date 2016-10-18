accessing
platform
	"Getting the set platform.
	Change it for testing.
	If not set it will use the default platform available in the system."
	
	^ platform ifNil: [ OSPlatform current ]