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
			package: 'Garage-Mysql' with: [ spec requires: #('Garage' ) ];
			package: 'Garage-Sqlite3' with: [spec requires: #('Garage' 'SQLite3')];
			package: 'Garage-Postgres' with: [spec requires: #('Garage' 'JSON' )].
		spec 
			group: 'default' with: #('ALL' );
			group: 'mysql' with: #('Garage-Mysql' );
			group: 'sqlite3' with: #('Garage-Sqlite3' );			
			group: 'pgsqlV2' with: #('Garage-Postgres' );
			group: 'postgresV2' with: #('Garage-Postgres' ) ].

]

{ #category : #baselines }
BaselineOfGarage >> project [
	^ super project
		loadType: #atomic;
		yourself
]
