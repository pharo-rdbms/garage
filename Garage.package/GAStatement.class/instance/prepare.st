execute
prepare

	"It prepares the current statement if the driver supports prepared statements."
	prepared ifTrue: [ self error: 'This statement is already prepared' ].
	prepared := true.