public API
with: aStatement at: aColumn putFloat: aFloat
	^ self apiBindDouble: aStatement atColumn: aColumn with: aFloat