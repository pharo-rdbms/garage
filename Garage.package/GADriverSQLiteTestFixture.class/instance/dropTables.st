as yet unclassified
dropTables

	self connection execute: 'DROP TABLE course'.
	self connection execute: 'DROP TABLE signature'.
	self connection execute: 'DROP TABLE student'.