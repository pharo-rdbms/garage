cleanup
cleanUp

	| toClean |
	"Private. Cleans up the current manager. If drivers were unloaded they will be removed from the manager on garbage collection."
	Smalltalk garbageCollect.
	toClean := drivers keys select: [ :key | (drivers at: key) isNil ].
	toClean do: [:key | drivers removeKey: key ]