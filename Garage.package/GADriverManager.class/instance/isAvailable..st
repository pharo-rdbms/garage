testing
isAvailable: aDriverId
	
	"Tests if a driver is available with the id given as argument."
	self cleanUp.
	^ drivers includesKey: aDriverId asLowercase asSymbol