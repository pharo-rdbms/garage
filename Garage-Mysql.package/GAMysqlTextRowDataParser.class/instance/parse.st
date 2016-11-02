preparing
parse
	|indx value row |

	row := GAMysqlRow new.
	row columnDescriptors: columnDescriptors.
	indx := 1.
	[inStream atEnd] whileFalse: [
		value := (self decodeLcsFrom: inStream) asString.
		value := self parseColumnValue: value byDescription: (columnDescriptors at: indx).
		row at: indx put: value.
		indx := indx + 1].
	^ row