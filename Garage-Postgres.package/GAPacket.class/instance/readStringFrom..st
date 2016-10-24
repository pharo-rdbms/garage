receiving
readStringFrom: connection

	| tmp ch |
	tmp := WriteStream on: String new.
	[ (ch := connection next) codePoint ~= 0 ] whileTrue: [
		tmp nextPut: ch.
	].
	^tmp contents

