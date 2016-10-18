private
options
	^ options
		ifNil: [ options := connectionString query
				ifNil: [ Dictionary new ]
				ifNotNil: #asDictionary ]