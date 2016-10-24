tests
testYearMonthDayInstanceCreation
	"#year:month:day: shortcuts #year:month:day:hour:minute:second:,
	but it should not forget about the offset.
	This test will fail to detect a problem if run where the local timezone offset is 0."
	| year month day date1 date2 |
	year := 2011.
	month := 2.
	day := 4.
	date1 := DateAndTime year: year month: month day: day hour: 0 minute: 0 second: 0.
	date2 := DateAndTime year: year month: month day: day.
	self assert: date1 = date2