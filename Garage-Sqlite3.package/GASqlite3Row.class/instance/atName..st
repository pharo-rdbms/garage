as yet unclassified
atName: aKey 
	^ self at: (resultSet indexOfColumnName: aKey) ifAbsent: [  ]