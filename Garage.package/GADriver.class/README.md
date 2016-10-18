This is the basic interface to instantiate and look for database drivers.

Database drivers subscribe themselves to a global driver manager using this class. Then, they are instantiated through it.

It also describes the minimal interface of all drivers. Its API contains the main methods to execute database queries, prepare statements and manage transactions. Also, to handle the differences between different drivers, this API provides a bunch of supports* methods to check the provided features.