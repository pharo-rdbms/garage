testing
supportsCursoredFetch

	"Tests if the current database driver supports cursored fetches. i.e., bringing database rows in batch instead of all in a row."
	^ self subclassResponsibility