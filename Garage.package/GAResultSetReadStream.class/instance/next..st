iterating
next: anInteger
	"Advances the stream and tries to retrieve the following N rows of the result set. If not enough rows are available, the retrieved array will contain only the available elements."

	^ Array
		streamContents: [ :str | 
			anInteger
				timesRepeat: [ self next ifNotNil: [ :next | str nextPut: next ] ] ]