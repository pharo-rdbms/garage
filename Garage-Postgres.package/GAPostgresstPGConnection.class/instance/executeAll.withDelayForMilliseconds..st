private
executeAll: queries withDelayForMilliseconds: millisecondDelay

	| conn result |

	conn := self newConnection.
	conn startup.
	queries do: [:each |
		Transcript nextPutAll: 'QUERY: '; nextPutAll: each; cr; flush.
		result := conn execute: each.
		result displayResultOn: Transcript.
		Transcript flush.
		millisecondDelay isNil ifFalse: [
			Transcript nextPutAll: 'Delaying for ', millisecondDelay printString, ' ms...'; cr.
			(Delay forMilliseconds: millisecondDelay) wait.
			Transcript flush.
		].
	].
	conn terminate.