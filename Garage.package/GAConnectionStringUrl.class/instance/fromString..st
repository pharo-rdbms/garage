as yet unclassified
fromString: aString

	| schemaStart schemaEnd authorityEnd hostEnd queryStart pathEnd |
	schemaStart := (aString indexOfSubCollection: '://') - 1.
	schemaEnd := schemaStart + 3.
	
	schema := (aString copyFrom: 1 to: schemaStart) asLowercase.
	
	queryStart := aString indexOf: $?.
	
	authorityEnd := (aString indexOf: $/ startingAt: schemaEnd + 1).
	authorityEnd <= 0 ifTrue: [
		queryStart > 0 ifTrue: [
			authorityEnd := queryStart.
		] ifFalse: [ authorityEnd := aString size + 1. ]
	].
	hostEnd := aString indexOf: $: startingAt: schemaEnd + 1.
	(hostEnd > authorityEnd or: [hostEnd = 0]) ifTrue: [
		hostEnd := authorityEnd.
	].

	host := (aString copyFrom: schemaEnd + 1 to: hostEnd - 1).
	((hostEnd + 1) < (authorityEnd - 1))
		ifTrue:[ port := (aString copyFrom: hostEnd + 1 to: authorityEnd - 1) ]
		ifFalse: [ port := '' ].
	
	queryStart = 0
		ifTrue: [ pathEnd := aString size ]
		ifFalse:[ pathEnd := queryStart -1].
	authorityEnd + 1 > pathEnd
		ifTrue:  [ path := '' ]
		ifFalse: [ path := (aString copyFrom: authorityEnd + 1 to: pathEnd)].
	
	queryStart > 0 ifTrue: [
		options := (ZnResourceMetaUtils parseQueryFrom: (ReadStream on: aString from: queryStart + 1 to: aString size)) asDictionary].