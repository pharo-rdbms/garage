accessing
atIndex: indx
	^ columnValues at: indx ifAbsent: [GAMysqlInvalidRowAccess signal: 'No data at this index']