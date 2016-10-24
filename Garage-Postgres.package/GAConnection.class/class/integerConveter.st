converters
integerConveter

	^[ :s | self readIntegerFrom: (ReadStream on: s) ].
