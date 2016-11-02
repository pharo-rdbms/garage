cursor
fetchMoreRows
	
	| result obtained |
	result := connection execute: 'FETCH FORWARD ', fetchSize asString, ' FROM ', name.
	obtained := result resultSets first rows.
	rows addAll: obtained.
	fetchListener ifNotNilDo: #fetchOccurred.
	finished := obtained isEmpty or: [ obtained size < fetchSize ].