as yet unclassified
dropTables

	self connection execute: 'DROP TABLE IF EXISTS course CASCADE'.
	self connection execute: 'DROP TABLE IF EXISTS signature CASCADE'. 
	self connection execute: 'DROP TABLE IF EXISTS student CASCADE'.