finalization
unregister

	"Unregisters the current driver from the weak registry. Calling this means that finalization will be manual"
	WeakRegistry default remove: self ifAbsent: [  ]