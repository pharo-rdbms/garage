postgres test suite
regressionTestNames

	^#(
		#('boolean' 'char' 'name' 'varchar' 'text' 'int2' 'int4' 'int8' 'oid' 'float4' 'float8' 'numeric')
		'strings'
		'numerology'
		#('point' 'lseg' 'box' 'path' 'polygon' 'circle' 'interval' 'timestamp' 'reltime' 'tinterval' 'inet' 'comments' 'oidjoins' 'type_sanity' 'opr_sanity')
		'abstime'
		'geometry'
		'horology'
		'create_function_1'
		'create_type'
		'create_table'
		'create_function_2'
		'copy'
		#('constraints' 'triggers' 'create_misc' 'create_aggregate' 'create_operator' 'create_index')
		'create_view'
		'sanity_check'
		'errors'
		'select'
		#('select_info' 'select_distinct' 'select_distinct_on' 'select_implicit' 'select_having' 'subselect' 'union' 'case' 'join' 'aggregates' 'transactions' 'random' 'portals' 'arrays' 'btree_index' 'hash_index')
		'misc'
		#('select_views' 'alter_table' 'portals_p2' 'rules' 'foreign_key')
		#('limit' 'plpgsql' 'temp')
	)