Class {
	#name : #GAMysqlConnectionData,
	#superclass : #Object,
	#instVars : [
		'host',
		'port',
		'user',
		'password',
		'database',
		'options'
	],
	#category : 'Garage-MySQL-Driver'
}

{ #category : #accessing }
GAMysqlConnectionData >> database: dbName [
	database := dbName
]

{ #category : #accessing }
GAMysqlConnectionData >> db [
	^ database
]

{ #category : #convenience }
GAMysqlConnectionData >> db: dbName [
	database := dbName
]

{ #category : #accessing }
GAMysqlConnectionData >> host [
	^ host
]

{ #category : #accessing }
GAMysqlConnectionData >> host: server [
	host := server
]

{ #category : #accessing }
GAMysqlConnectionData >> options: driverOptions [
	options := driverOptions
]

{ #category : #accessing }
GAMysqlConnectionData >> password [
	^ password
]

{ #category : #accessing }
GAMysqlConnectionData >> password: userPassword [
	password := userPassword
]

{ #category : #accessing }
GAMysqlConnectionData >> port [
	^ port
]

{ #category : #accessing }
GAMysqlConnectionData >> port: serverPort [
	port := serverPort
]

{ #category : #accessing }
GAMysqlConnectionData >> user [
	^ user
]

{ #category : #accessing }
GAMysqlConnectionData >> user: userName [
	user := userName
]
