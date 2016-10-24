accessing
dataKeyedByFieldName

	| d |

	d := Dictionary new.
	self data with: description columnDescriptions do: [:each :aColumnDescription |
		d at: aColumnDescription fieldName put: each.
	].
	^ d
