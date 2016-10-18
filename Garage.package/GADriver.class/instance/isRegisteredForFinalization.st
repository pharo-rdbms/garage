finalization
isRegisteredForFinalization

	"Tests if the current driver instance is registered in the weak registry for finalization or not"
	^ WeakRegistry default includes: self