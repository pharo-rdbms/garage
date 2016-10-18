I am a simple driver manager that handle the subscriptions of database drivers. You can also ask a driver manager which are the installed drivers and get a driver by id.

Drivers are handled in a weak way: unloading a driver will eventually garbage collect the driver and the manager will be cleaned up.