as yet unclassified
atName: aSymbol ifAbsent: aBlock

	^self at: (dictionary 
		at: aSymbol
		ifAbsent: [ ^aBlock value ])