accessing
scrambleBuff
	
	^ scrambleBuff
	
	"self supports41 
		ifTrue: [^ scrambleBuff, scrambleBuffMore]
		ifFalse: [^ scrambleBuff]."