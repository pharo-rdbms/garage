postgres test suite
runRegressionTests
	"TestPGConnection new runRegressionTests"

	self regress: 'drop'.
	(self regressionTestNames at: 1) do: [:each | self regress: each].
	"self regressionTestNames do: [:test |
		test isString
			ifTrue: [self regress: test]
			ifFalse: [test do: [:each | self regress: each]]
	]."
