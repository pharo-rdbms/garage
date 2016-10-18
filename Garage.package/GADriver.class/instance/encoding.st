encoding
encoding
	
	"Returns the configured encoding for this driver instance.
	Default: 'utf8'"
	^ encoding ifNil: [ encoding := connectionString optionAt: 'encoding' ifAbsent: 'utf8' ]