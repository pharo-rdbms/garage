receiving
readFieldFrom: connection

	| n tmp |

	n := (self readInt32From: connection) - 4.
	tmp := WriteStream on: String new.
	1 to: n do: [:i |
		tmp nextPut: connection next.
	].
	^tmp contents
