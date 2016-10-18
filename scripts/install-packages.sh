./pharo Pharo.image eval "
Metacello new 
	baseline: 'Garage';
	repository: 'filetree://.';
	load: '$1'.
Smalltalk snapshot: true andQuit: true.
"