private
signal: exceptionClass with: value on: handle
	exceptionClass new resultCode: value; signal: (self apiErrorMessage: handle)