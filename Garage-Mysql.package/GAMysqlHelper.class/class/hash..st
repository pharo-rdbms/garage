private
hash: message
	"Computes a hash form byte strings,
	Returns an array of large positive integers.
	Used in pre-4.1 authentication scheme"
	
"118 {
119   register ulong nr=1345345333L, add=7, nr2=0x12345671L;
120   ulong tmp;
121   const char *password_end= password + password_len;
122   for (; password < password_end; password++)
123   {
124     if (*password == ' ' || *password == '\t')
125       continue;                                 /* skip space in password */
126     tmp= (ulong) (uchar) *password;
127     nr^= (((nr & 63)+add)*tmp)+ (nr << 8);
128     nr2+=(nr2 << 8) ^ nr;
129     add+=tmp;
130   }
131   result[0]=nr & (((ulong) 1L << 31) -1L); /* Don't use sign bit (str2int) */;
132   result[1]=nr2 & (((ulong) 1L << 31) -1L);
133 }"

	| nr add nr2 tmp |

	nr := 1345345333. add := 7. nr2 := 16r12345671.
	message do: [:each |
		((each = Character space) or: [each = Character tab]) ifTrue: [] ifFalse: [
			tmp := each.
			nr := nr bitXor: ((((nr bitAnd: 63) + add) * tmp asInteger) + (nr bitShift: 8)).
			nr2 := nr2 + ((nr2 bitShift: 8) bitXor: nr).
			add := add + tmp asInteger.
		]].
	
	^Array with:(nr bitAnd: ((1 bitShift: 31) - 1)) with: (nr2 bitAnd: ((1 bitShift: 31) - 1))


