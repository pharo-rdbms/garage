private-states
stGotBackendKeyData: backendKeyData
	"event is a BackendKeyData packet."

	processId := backendKeyData processId.
	secretKey := backendKeyData secretKey.
