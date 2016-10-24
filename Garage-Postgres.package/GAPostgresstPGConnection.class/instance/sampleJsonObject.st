tests
sampleJsonObject
	| jsonObject |
	jsonObject := JsonObject new
		at: 'string' put: 'Hello world';
		at: 'number' put: 10;
		at: 'float' put: 10.2;
		at: 'boolean' put: true;
		at: 'collection' put: #(1 2 3 5 8 11 19);
		at: 'mixedCollection' put: #(1 'Hello' false);
		yourself.
	^ jsonObject