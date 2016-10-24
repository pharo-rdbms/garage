printing
displayRowsOn: aStream

	rows do: [:each | each displayOn: aStream. aStream cr.].
