drivers
subscribeDriver: aDriver

	"Subscribes weakly the driver given as argument in the current manager"
	drivers at: aDriver driverId asLowercase asSymbol put: aDriver