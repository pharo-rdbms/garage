I am a fixture setting up and tearing down the database and tables needed for running tests.

Each of my concrete subclasses implement the particular details of a database vendor. That is, for each driver flavor, one of me should be available.

For insight into my usage, look at the setup and teardown methods in DBXDriverTest