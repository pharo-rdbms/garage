initialize-release
initialize
	"GAPacket initialize"

	PacketClasses := IdentityDictionary new
		at: $K put: GABackendKeyData;
		at: $R put: GAAuthentication;
		at: $C put: GACompletedResponse;
		at: $G put: GACopyInResponse;
		at: $H put: GACopyOutResponse;
		at: $P put: GACursorResponse;
		at: $I put: GAEmptyQueryResponse;
		at: $E put: GAErrorResponse;
		at: $V put: GAFunctionResultResponse;
		at: $N put: GANoticeResponse;
		at: $A put: GANotificationResponse;
		at: $Z put: GAReadyForQuery;
		at: $T put: GAPostgresRowDescription;
		at: $D put: GAAsciiRow;
		at: $B put: GABinaryRow;
		yourself