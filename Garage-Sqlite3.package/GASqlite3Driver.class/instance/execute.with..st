query
execute: aQuery with: anObject

	^ GASqlite3ResultSet new execute: aQuery with: anObject on: self