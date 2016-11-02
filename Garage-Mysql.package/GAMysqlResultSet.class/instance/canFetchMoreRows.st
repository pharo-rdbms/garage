cursor
canFetchMoreRows

	^ self hasOpenCursor and: [self hasLastRowSent not]