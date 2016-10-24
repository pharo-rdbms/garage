api
terminate

	self queueEvent: #Terminate.
	self saProcessEventsUntil: #(Terminated ConnectionFailed).
