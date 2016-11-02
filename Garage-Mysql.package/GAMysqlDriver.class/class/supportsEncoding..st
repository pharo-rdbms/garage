encoding
supportsEncoding: aString 
	
	"Mysql only supports in the client encodings that are compatible with ascii.
	Cite: ucs2, utf16, and utf32 cannot be used as a client character set, which means that they do not work for SET NAMES or SET CHARACTER SET."
	
	" check 
	  https://dev.mysql.com/doc/refman/5.5/en/charset-charsets.html
	  https://dev.mysql.com/doc/refman/5.5/en/charset-connection.html"
	^ 'utf8' = aString