Class {
	#name : #BaselineOfGarage,
	#superclass : #BaselineOf,
	#category : #BaselineOfGarage
}

{ #category : #baselines }
BaselineOfGarage >> baseline: spec [
	<baseline>

	spec for: #'common' do: [
		spec blessing: #'baseline'.
		spec baseline: 'SQLite3' 
					with: [ spec repository: 'github://pharo-rdbms/Pharo-SQLite3:master/'].
		spec baseline: 'MySQL' 
					with: [ spec repository: 'github://pharo-db/Pharo-MySQL:master/'].
		spec baseline: 'P3' 
					with: [ spec repository: 'github://svenvc/P3'].
		spec 
			project: 'JSON' with: [
				spec
					className: #ConfigurationOfJSON;
					versionString: '1.1';
					repository: 'http://smalltalkhub.com/mc/PharoExtras/JSON/main/' ].
		spec 
			package: 'Garage';
			package: 'Garage-MySQL' with: [ spec requires: #('Garage' 'MySQL') ];
			package: 'Garage-SQLite3' with: [spec requires: #('Garage' 'SQLite3')];
			package: 'Garage-Postgres' with: [spec requires: #('Garage' 'JSON' )];
			package: 'Garage-P3' with: [ spec requires: #('Garage' 'P3' )].
		spec 
			group: 'default' with: #('ALL' );
			group: 'mysql' with: #('Garage-MySQL' );
			group: 'sqlite3' with: #('Garage-SQLite3' );			
			group: 'pgsqlV2' with: #('Garage-Postgres' );
			group: 'postgresV2' with: #('Garage-Postgres' ) ].

]

{ #category : #baselines }
BaselineOfGarage >> project [
	^ super project
		loadType: #atomic;
		yourself
]
