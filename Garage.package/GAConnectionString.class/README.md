I am a database connection string for url-like connections. For example:

mysql://localhost:5432/sodbxtest?&user=sodbxtest&password=sodbxtest

More generally, a connection string is written as:

driver://host:port/database?key=value&key2=value2

Internally, I use ZnUrl to parse and access the data inside a connection string.