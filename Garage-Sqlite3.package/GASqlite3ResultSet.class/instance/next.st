iterating
next
	| nc rr |

	statement ifNil: [ GASqlite3Misuse signal: 'This result set does not contain a prepared statement.' ].	

	moreRows ifTrue: [	
		nc := statement dataValuesAvailable.
		(nc = 0)
			ifTrue: [ ^ nil ] 
			ifFalse: [ 
				rr := GASqlite3Row new.
				rr resultSet: self.
				0 to: nc - 1 do: [ :c | rr at: c + 1 put: (statement valueOfColumn: c) ].
				"statement clearBindings." "XXX With this, the Glorp result set fails its test..."
				moreRows := (statement step) = 100. " == SQLITE_ROW "
				^ rr ]].
		
	^ nil