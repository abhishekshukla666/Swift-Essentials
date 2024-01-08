
import Foundation
//
//let dateString = "2022-11-02T09:14:14.535054"
let formatter = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS"
//
//let utcDateFormatter = DateFormatter()
//dateFormatter.dateFormat = formatter
//
//utcDateFormatter.dateStyle = .medium
//utcDateFormatter.timeZone = TimeZone(abbreviation: "UTC")
//let result = utcDateFormatter.date(from: dateString)
//
//print(result)

let utcDateFormatter = DateFormatter()
utcDateFormatter.dateFormat = formatter

// The default timeZone on DateFormatter is the device’s
// local time zone. Set timeZone to UTC to get UTC time.
utcDateFormatter.timeZone = TimeZone(abbreviation: "UTC+1:00")
//utcDateFormatter.locale = Locale(identifier: "de_DE")


// Parsing a string representing a date
let dateString = "2022-11-02T12:54:36.32019"
let utcDate = utcDateFormatter.date(from: dateString)
//print(utcDate!)


/*
 Closures
 */

func addNumber(_ num1: Int, _ nums2: Int) -> Int {
    return num1 + nums2
}

//let addInteger = addNumber // Function
let addInteger: (Int, Int) -> Int = {
    (num1, num2) in
    return num1 + num2
}

let result = addInteger(1, 10)
//print(result)


func printMessage(_ isEnabled: Bool, _ name: () -> String) {
    if isEnabled {
        print("Hi Good Morning \(name())!")
    }
}

func getName(_ name: String) -> String {
    debugPrint("getName called")
    return name
}

printMessage(true, {
    getName("abhishek")
})
printMessage(false, {
    getName("shukla")
})
/* Output
"getName called"
Hi Good Morning abhishek!
 */


