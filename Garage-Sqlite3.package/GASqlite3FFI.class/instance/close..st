public API
close: aHandle	
	^ self checkForOk: (self apiClose: aHandle) on: aHandle
	
