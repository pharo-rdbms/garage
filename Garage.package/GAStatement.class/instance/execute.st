execute
execute

	"It executes the current statement."
	fetchListener ifNotNilDo: #fetchOccurred.
	^ connection execute: statement.