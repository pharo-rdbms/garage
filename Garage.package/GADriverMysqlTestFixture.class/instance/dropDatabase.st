as yet unclassified
dropDatabase

	setupConnection ifNil: [ ^ self ].
	setupConnection execute: 'drop database if exists sodbxtest'.