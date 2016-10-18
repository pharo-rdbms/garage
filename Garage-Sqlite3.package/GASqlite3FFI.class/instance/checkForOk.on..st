private
checkForOk: aValue on: aHandle

	(aValue = OK)
		ifFalse: [ 
			(aValue = BUSY)
				ifTrue: [ self signal: GASqlite3Busy with: aValue on: aHandle ].
			(aValue = LOCKED)
				ifTrue: [ self signal: GASqlite3Locked with: aValue on: aHandle ].
			(aValue = MISUSE)
				ifTrue: [ self signal: GASqlite3Misuse with: aValue on: aHandle ].				
			self signal: GASqlite3Error with: aValue on: aHandle ].	
	^ OK