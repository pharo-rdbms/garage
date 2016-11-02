as yet unclassified
readOneRow: fields
	| parser |
	parser := GAMysqlTextRowDataParser new.
	parser driver: driver.
	parser columnDescriptors: fields.
	^ parser read: session read.
	