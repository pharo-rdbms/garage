as yet unclassified
execute: anSQLText withCollection: aCollection
	| i |

	self prepareStatement: anSQLText.
	i := 1.
	aCollection do: [ :v | i := self execute: statement withIndex: i withValue: v ].
	moreRows := (statement step) = 100. " == SQLITE_ROW "