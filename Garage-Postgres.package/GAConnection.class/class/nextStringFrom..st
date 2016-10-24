private
nextStringFrom: readStream

	| escape |
	^String streamContents: [ :stream |
		readStream peek = $" 
			ifFalse: [ 
				[ #($, $}) includes: readStream peek ] whileFalse: [ 
					stream nextPut: readStream next ] ]
			ifTrue: [
				escape := false.
				readStream skip: 1.
				[ escape not and: [ readStream peek = $" ] ] whileFalse: [ 
					| character |
					character := readStream next.
					escape 
						ifTrue: [
							stream nextPut: character.
							escape := false ]
						ifFalse: [
							escape := character = $\.
							escape ifFalse: [ stream nextPut: character ] ].
					].
				readStream skip: 1 ].
		readStream skip: 1 " drop comma or curlybrace " ]