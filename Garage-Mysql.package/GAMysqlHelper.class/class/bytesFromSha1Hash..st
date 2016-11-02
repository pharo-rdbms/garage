as yet unclassified
bytesFromSha1Hash: num 

	| index bytes |

	index := 0.
	bytes := ByteArray new: (num digitLength max: 20).	"gurantee 20 bytes; required for authentication"
		
	(20 - num digitLength) to: 1 by: -1 do: [ :i | bytes at: (index := index + 1) put: (0 digitAt: 1) ].	"filler 0 from msbyte"
	num digitLength to: 1 by: -1 do: [ :i | bytes at: (index := index + 1) put: (num digitAt: i) ].
	^ bytes