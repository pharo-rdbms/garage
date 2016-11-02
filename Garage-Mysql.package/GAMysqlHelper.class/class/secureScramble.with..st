as yet unclassified
secureScramble: seed with: password 

	| sha1 hashStage1 hashStage2 hash3 reply |

	sha1 := SHA1 new.

	hashStage1 := (sha1 hashMessage: password) asInteger.
	hashStage2 := (sha1 hashMessage: (self bytesFromSha1Hash: hashStage1)) asInteger.

	hash3 := (sha1 hashMessage: seed asByteArray , (self bytesFromSha1Hash: hashStage2)) asInteger.

	reply := self bytesFromSha1Hash: (hashStage1 bitXor: hash3).
	^ reply