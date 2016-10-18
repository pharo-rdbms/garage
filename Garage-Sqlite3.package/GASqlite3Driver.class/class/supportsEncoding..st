encoding
supportsEncoding: anEncoding
	
	^ (ZnCharacterEncoder newForEncoding: anEncoding) = ZnUTF8Encoder new