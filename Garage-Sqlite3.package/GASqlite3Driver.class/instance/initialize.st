initialize-release
initialize
	super initialize.

	handle := GASQLite3DatabaseExternalObject new.
	isOpen := false.