initialization
buildStateTransitionTable
	"self resetStateTransitionTable"

	^#(
	(Created (
		(Startup Startup)))
	(Startup (
		(AuthenticationKerberosV4 UnsupportedAuthentication)
		(AuthenticationKerberosV5 UnsupportedAuthentication)
		(AuthenticationCleartextPassword SendingCleartextPassword)
		(AuthenticationCryptPassword UnsupportedAuthentication)
		(AuthenticationMD5Password	SendingMD5Password)
		(AuthenticationSCMCredential UnsupportedAuthentication)
		(AuthenticationOk AuthenticationOk)
		(ConnectionFailed ConnectionFailed)
		(Terminate Terminated)
		(ErrorResponse TerminalError)))
	(SendingCleartextPassword (
		(AuthenticationOk AuthenticationOk)
		(Terminate Terminated)
		(ErrorResponse TerminalError)))
	(SendingMD5Password (
		(AuthenticationOk AuthenticationOk)
		(Terminate Terminated)
		(ErrorResponse TerminalError)))
	(UnsupportedAuthentication (
		(Terminate Terminated)))
	(AuthenticationOk (
		(BackendKeyData GotBackendKeyData)
		(Terminate Terminated)
		(ErrorResponse TerminalError)))
	(GotBackendKeyData (
		(ReadyForQuery ReadyForQuery)
		(Terminate Terminated)
		(ErrorResponse ErrorResponse)))
	(ReadyForQuery (
		(Query Querying)
		(FunctionCall FunctionCall)
		(Terminate Terminated)
		(ErrorResponse ErrorResponse)))
	(Querying (
		(CursorResponse GotCursor)
		(CopyOutResponse GotCopyOut)
		(CopyInResponse GotCopyIn)
		(CompletedResponse GotCompleted)
		(Terminate Terminated)
		(ErrorResponse ErrorResponse)))
	(FunctionCall (
		(FunctionResultResponse GotFunctionResult)
		(Terminate Terminated)
		(ErrorResponse ErrorResponse)))
	(GotCursor (
		(RowDescription GotRowDescription)
		(CompletedResponse GotCompleted)
		(Terminate Terminated)
		(ErrorResponse ErrorResponse)))
	(GotRowDescription (
		(AsciiRow GotRow)
		(BinaryRow GotRow)
		(CompletedResponse GotCompleted)
		(Terminate Terminated)
		(ErrorResponse ErrorResponse)))
	(GotRow (
		(AsciiRow GotRow)
		(BinaryRow GotRow)
		(CompletedResponse GotCompleted)
		(Terminate Terminated)
		(ErrorResponse ErrorResponse)))
	(GotCopyOut (
		(CompletedResponse GotCompleted)
		(Terminate Terminated)
		(ErrorResponse ErrorResponse)))
	(GotCopyIn (
		(CompletedResponse GotCompleted)
		(Terminate Terminated)
		(ErrorResponse ErrorResponse)))
	(GotFunctionResult (
		(ReadyForQuery ReadyForQuery)
		(CompletedResponse GotCompleted)
		(Terminate Terminated)
		(ErrorResponse ErrorResponse)))
	(GotCompleted (
		(ReadyForQuery ReadyForQuery)
		(CursorResponse GotCursor)
		(CompletedResponse GotCompleted)
		(Terminate Terminated)
		(ErrorResponse ErrorResponse)))
	(Terminated (
		(Startup Startup)))
	(ConnectionFailed (
		(Startup Startup)
		(Query EventIgnored)
		(FunctionCall EventIgnored)
		(Terminate EventIgnored)))
	(ErrorResponse (
		(Terminate Terminated)
		(ReadyForQuery ReadyForQuery)
		(CompletedResponse GotCompleted)))
	(TerminalError (
		))
	)
	inject: IdentityDictionary new
	into: [:table :each |
		table
			at: (each at: 1)
			put: ((each at: 2)
					inject: IdentityDictionary new
					into: [:stateTransitions :transition |
						stateTransitions at: (transition at: 1) put: (transition at: 2).
						stateTransitions]).
		table].
