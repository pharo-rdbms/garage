./pharo Pharo.image eval "
Metacello new 
	baseline: 'Garage';
	repository: 'filetree://.';
	load: 'sqlite3'.
Smalltalk snapshot: true andQuit: true.
"