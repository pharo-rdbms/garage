as yet unclassified
hexStringFromBytes: aByteArray
	^ aByteArray inject: '' into: [:result :each | 
		result, (each printPaddedWith: $0 to: 2 base: 16)].
