accessing
connection
	
	^ connection ifNil:[ connection := self newConnection ]