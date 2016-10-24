instance creation
oid: anInteger arguments: aCollection
	"Return a new instance of the receiver.

	'anInteger' specifies the object ID of the function to call. The object ID is a site specific PostgreSQL value.
	'aCollection' contains the arguments of the function call. It should contain String values, which may have non-printable characters (i.e. values 0..255).
	"

	^ self new setOid: anInteger arguments: aCollection
