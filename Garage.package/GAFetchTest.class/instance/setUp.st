running
setUp

	super setUp.
	"We create a lot of students"
	conn execute: 'INSERT INTO student(id) VALUES (1)'.
	1 to: 200 do: [ :i | conn execute: 'INSERT INTO signature(code, name, observations, id_student) VALUES (', i asString ,', ''TADP'', ''Tecnicas Av'', 1)'].