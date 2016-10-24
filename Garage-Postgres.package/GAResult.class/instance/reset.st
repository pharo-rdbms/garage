initialization
reset
	"Clear the previous results in preparation to hold new query results."

	"There's an opportunity to tweak the code here for performance.
	If the result sets are cleared each time, then there's a lot of
	re-allocation. But, if the old results are just cleared, an earlier
	large result set may cause a large collection to remain in memory.
	Maybe it's just better to let GC handle it.
	"

	self errorResponse: nil.
	self functionResult: nil.
	resultSets := OrderedCollection new.
