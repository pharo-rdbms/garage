execute
execute
	
	^ fetchSize ifNil: [
		fetchListener ifNotNil: #fetchOccurred.
		connection execute: self executionStatement.
	] ifNotNil: [
		^ GAPostgresCursoredResult new
			connection: connection;
			fetchListener: fetchListener;
			fetchSize: fetchSize;
			statement: self;
			declare;
			yourself
	]