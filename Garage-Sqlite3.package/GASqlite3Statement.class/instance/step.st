public
step

	| result |
	result := GASqlite3FFI current step: handle.
	(#[101 100] includes: result) not
		ifTrue: [ GASqlite3FFI current signal: GASqlite3Error with: result on: connection handle].
	^ result