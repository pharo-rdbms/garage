postgres test suite
regress: testName

	| inStream conn outStream line pos result sql |

	Transcript show: testName, '--starting test'; cr.
	conn := self newConnection.
	conn startup.

	inStream := FileStream readOnlyFileNamed: 'u:\lib\pgsql\test\regress\sql\', testName, '.sql'.
	outStream := FileStream newFileNamed: testName, '.out'.
	sql := ''.
	[inStream atEnd] whileFalse: [
		line := inStream upTo: Character lf.
		(line beginsWith: '--')
			ifTrue: [outStream nextPutAll: line; cr].
		(line size > 0 and: [(line beginsWith: '--') not]) ifTrue: [
			pos := line findString: '\g'. "\g is psql execute command"
			pos > 0 ifTrue: [line := line copyFrom: 1 to: pos - 1].
			sql := sql, line, String cr.
			(line endsWith: ';') ifTrue: [
				result := conn execute: sql.
				Transcript show: sql; flush.
				outStream nextPutAll: sql.
				result displayResultOn: outStream.
				sql := ''.
			].
		].
	].
	inStream close.
	outStream close.

	conn terminate.
	Transcript show: testName, '--test completed'; cr.
