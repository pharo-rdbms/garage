as yet unclassified
readOneRow: fields 
	| parser |
	parser := GAMysqlBinaryRowDataParser new.
	parser driver: driver.
	parser columnDescriptors: fields.
	^ parser read: session read.