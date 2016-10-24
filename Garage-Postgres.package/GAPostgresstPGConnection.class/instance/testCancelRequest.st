tests
testCancelRequest
	"Test: CancelRequest.

	Set the debug level of the postmaster daemon to 1 or greater.
	Capture the postmaster output in a log file.
	Examine the log file for a cancel request with a matching process id.

	Example, an init.d script containing:
		su -l postgres -s /bin/sh -c ""/usr/bin/pg_ctl  -D $PGDATA -p /usr/bin/postmaster -o '-i -d 1' start  > /var/log/postgresql/log 2>&1"" < /dev/null
	yields a line in the log:
		/usr/bin/postmaster: processCancelRequest: sending SIGINT to process 13142
	"

	| conn |

	conn := self newConnection.
	conn startup.
	conn cancelRequest.
	conn terminate.
