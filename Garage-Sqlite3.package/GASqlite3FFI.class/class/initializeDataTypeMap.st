class initialization
initializeDataTypeMap

	DataTypeMap := Dictionary newFromPairs: #(
		1			#integerAt: 
		2			#floatAt:
		3			#stringAt:
		4			#byteArrayAt:
		5			#nilAt:
	)