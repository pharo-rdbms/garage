tests
testConvertersWith: aPGConnection

	{ 
		'select b::boolean from (values (true), (false), (null)) t(b)' -> #(true false nil).
		'select array[true, false, null]::boolean[]' -> #((true false nil)).
		'select i::integer from (values (-1), (1), (null), (1234567890)) t(i)' -> #(-1 1 nil 1234567890).
		'select array[1, 2, null, -1]::integer[]' -> #((1 2 nil -1)).
		"'select array[''foo'', ''bar'', null, ''baz'']::text[]' -> #(('foo' 'bar' nil 'baz'))"
		'select d::date from (values (''1234-12-30''), (null), (''2009-01-31'')) t(d)' -> { Date year: 1234 month: 12 day: 30. nil. Date year: 2009 month: 1 day: 31 }.
		
	} do: [ :each |
		| dataRows |
		dataRows := (aPGConnection executeAndCheckResult: each key) dataRows.
		self assert: (dataRows collect: [ :row | row at: 1 ]) asArray = each value ]
	