public API
open: aFilename via: aHandle	
	^ self checkForOk: (self apiOpen: aFilename via: aHandle) on: aHandle
	
