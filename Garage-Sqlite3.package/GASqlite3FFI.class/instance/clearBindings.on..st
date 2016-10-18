public API
clearBindings: sHandle on: dbHandle	
	^ self checkForOk: (self apiClearBindings: sHandle) on: dbHandle
	
