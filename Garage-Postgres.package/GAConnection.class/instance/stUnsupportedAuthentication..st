private-states
stUnsupportedAuthentication: event

	"result errorResponse: 'Unsupported authentication method: ', event eventName."

	GAPostgresUnsupportedAuthentication signal: 'Unsupported authentication method: ', event eventName.
