"
This class has methods to configure the connection strings to run the tests from the CI infrastructure
"
Class {
	#name : #GAContinuousIntegrationConfiguration,
	#superclass : #Object,
	#category : 'Garage-CI'
}

{ #category : #'as yet unclassified' }
GAContinuousIntegrationConfiguration >> configureFixtureWithConnectionString: aConnectionString andSetupConnectionString: aSetupConnectionString [
	
	GADriverTest fixture: (GADriverTestFixture 
		setupConnectionString: aSetupConnectionString
		connectionString: aConnectionString).
]

{ #category : #'as yet unclassified' }
GAContinuousIntegrationConfiguration >> configureMysql [

	self
		configureFixtureWithConnectionString: 'mysql://localhost:3306/sodbxtest?user=sodbxtest&password=sodbxtest'
		andSetupConnectionString: 'mysql://localhost:3306?user=sodbxtest&password=sodbxtest'.
]

{ #category : #'as yet unclassified' }
GAContinuousIntegrationConfiguration >> configureOpenDbxSqlite [

	self
		configureFixtureWithConnectionString: 'opendbx://memory?backend=sqlite3'
		andSetupConnectionString: 'opendbx://memory?backend=sqlite3'.
]

{ #category : #'as yet unclassified' }
GAContinuousIntegrationConfiguration >> configurePostgresql [

	self
		configureFixtureWithConnectionString: 'postgresV2://localhost:5432/sodbxtest?user=sodbxtest&password=sodbxtest'
		andSetupConnectionString: 'postgresV2://localhost:5432/postgres?user=postgres&password=postgres'.
]

{ #category : #'as yet unclassified' }
GAContinuousIntegrationConfiguration >> configureSqlite3 [

	self
		configureFixtureWithConnectionString: 'sqlite3://memory'
		andSetupConnectionString: 'sqlite3://memory'.
]
