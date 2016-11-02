as yet unclassified
listOfSize: count forDescriptors: fields
	| params |
	params := (1 to: count) collect: [:each |  
			(self new 
				declaredUnsigned: (fields at: each) isUnsigned; 
				yourself)].
	^ params
	