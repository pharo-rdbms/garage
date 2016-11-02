public
scramble323: message with: password 
	"Scamble the bytestring message with password."
	"Return a srambled byte string."
	"Used in pre-4.1 authentication scheme"
	| hashPass hashMessage outMessage extra byteValue rnd msgUsed |
	password isEmptyOrNil ifTrue: [ ^ '' ].

	msgUsed := message first: (self scramble323MessageLimit min: message size).
	hashPass := self hash: password.
	hashMessage := self hash: msgUsed. "323 size limit"
		
	self 
		randomInitWith: ((hashPass first) bitXor: (hashMessage first))
		and: ((hashPass at: 2) bitXor: (hashMessage at: 2)).

	outMessage := ByteArray new: msgUsed size.
	1 to: outMessage size do: [ :indx | 
		rnd := self myRandom.
		byteValue := ((rnd * 31) floor + 64) bitAnd: 255.
		outMessage at: indx 	put: byteValue].

	rnd := self myRandom.
	extra := (rnd * 31) floor bitAnd: 255.
	1 to: outMessage size
		do: 
			[ :indx | 
			byteValue := (outMessage at: indx) asInteger bitXor: extra.
			outMessage at: indx 	put: byteValue ].

	^ outMessage
	