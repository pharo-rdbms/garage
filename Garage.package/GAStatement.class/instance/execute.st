execute
execute

	"It executes the current statement."
	fetchListener ifNotNil: #fetchOccurred.
	^ connection execute: statement.