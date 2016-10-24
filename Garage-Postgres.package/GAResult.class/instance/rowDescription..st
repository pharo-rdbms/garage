accessing-convenience
rowDescription: aRowDescription

	| rs |

	rs := self lastResultSet.
	rs rowDescription: aRowDescription.
	rs result: self.
	aRowDescription resultSet: rs.
