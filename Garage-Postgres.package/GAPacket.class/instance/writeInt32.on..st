sending
writeInt32: anInteger on: aStream

	aStream
		nextPut: (Character value: ((anInteger bitShift: -3*8) bitAnd: 16rFF));
		nextPut: (Character value: ((anInteger bitShift: -2*8) bitAnd: 16rFF));
		nextPut: (Character value: ((anInteger bitShift: -1*8) bitAnd: 16rFF));
		nextPut: (Character value: ((anInteger bitShift: 0*8) bitAnd: 16rFF));
		yourself.
