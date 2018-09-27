# Garage

Database drivers for the Pharo language.

## Drivers

Garage currently has drivers for:
- PostgreSQL V2
- MySQL
- SQLLite 3

## Install Garage

To install Garage on your Pharo image you can just execute the following script: 

```Smalltalk
    Metacello new
    	githubUser: 'pharo-rdbms' project: 'garage' commitish: 'master' path: '';
    	baseline: 'Garage';
    	load
```

To add Garage Seaside to your baseline just add this:

```Smalltalk
    spec
    	baseline: 'Garage'
    	with: [ spec repository: 'github://pharo-rdbms/garage:master' ]
```

Note that you can replace the #master by another branch as #development or a tag as #v1.0.0, #v1.?.

You can also load a specific driver adding this snippet to your baseline:

```Smalltalk
	spec
		baseline: 'Garage'
		with: [ spec
				loads: 'postgresV2';
				repository: 'gitlab://pharo-rdbms/garage' ]
```

Possible drivers been:
- postgresV2
- sqlite3
- mysql

