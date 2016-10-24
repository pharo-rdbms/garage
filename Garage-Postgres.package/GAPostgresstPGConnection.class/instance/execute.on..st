private
execute: sql on: conn

	| result resultStream |

	resultStream := ReadWriteStream on: String new.
	result := conn execute: sql.
	result displayResultOn: resultStream.
	^ resultStream contents.
