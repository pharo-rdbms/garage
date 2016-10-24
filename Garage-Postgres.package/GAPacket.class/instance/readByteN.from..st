receiving
readByteN: n from: connection

	| bytes |

	bytes := ByteArray new: n.
	1 to: n do: [:i | bytes byteAt: i put: connection next codePoint].
	^bytes