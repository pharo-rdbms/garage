public
basicExecute: anSQLText

	^ GASqlite3FFI current execute: anSQLText on: handle