accessing
databasePath
	
	"If it is windows, we remove the extra / at the beginning"
	^ (self platform isWindows
		ifTrue: [ connectionString pathPrintString allButFirst ]
		ifFalse: [ connectionString pathPrintString ]) urlDecoded