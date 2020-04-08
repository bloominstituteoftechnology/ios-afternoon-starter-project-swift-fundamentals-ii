import UIKit


//: ## 1. Create custom types to represent an Airport Departures display
//: ![Airport Departures](matthew-smith-5934-unsplash.jpg)
//: Look at data from [Departures at JFK Airport in NYC](https://www.airport-jfk.com/departures.php) for reference.
//:
//: a. Use an `enum` type for the FlightStatus (En Route, Scheduled, Canceled, Delayed, etc.)
//:
//: b. Use a struct to represent an `Airport` (Destination or Arrival)
//:
//: c. Use a struct to represent a `Flight`.
//:
//: d. Use a `Date?` for the departure time since it may be canceled.
//:
//: e. Use a `String?` for the Terminal, since it may not be set yet (i.e.: waiting to arrive on time)
//:
//: f. Use a class to represent a `DepartureBoard` with a list of departure flights, and the current airport
enum FlightStatus : String {
    case SCHEDULED
    case CANCELED
    case DELAYED
    case BOARDING
}

struct Airport {
    var mIsDestination: Bool // false for arrival, true for departure
    var mName: String
}

struct Flight {
    var mDepartureTime: Date?
    var mTerminal: String?
    var mDestination: Airport?
    var mAirline: String?
    var mFlightStatus: FlightStatus?
    var mFlightNumber: String?
}

infix operator ???: NilCoalescingPrecedence

public func ???<T>(optional: T?, defaultValue: @autoclosure () -> String) -> String {
    switch optional {
    case let value?: return String(describing: value)
    case nil: return defaultValue()
    }
}

class DepartureBoard {
    var mDepartures: [Flight]
    var mAirport: Airport
    
    init(_ departures: [Flight], _ airport: Airport) {
        self.mDepartures = departures
        self.mAirport = airport
    }

    func alertPassengers() {
        let df = DateFormatter()
        df.timeStyle = .short
        df.dateStyle = .medium
        df.locale = Locale(identifier: "en_US")
        
        for flight in mDepartures {
        
            if let unwrappedFlightStatus = flight.mFlightStatus,
                let unwrappedDestination = flight.mDestination?.mName,
                let unwrappedDepartureTime = flight.mDepartureTime,
                let unwrappedTerminal = flight.mTerminal {
                switch unwrappedFlightStatus {
                    case FlightStatus.CANCELED:
                        print("We're sorry your flight to \(unwrappedDestination) was canceled, here is a $500 voucher")
                    case FlightStatus.SCHEDULED:
                        print("Your flight to \(unwrappedDestination) is scheduled to depart at \(df.string(from: unwrappedDepartureTime) ??? "TBD") from terminal: \(unwrappedTerminal ??? "TBD")")
                    case FlightStatus.BOARDING:
                        print("Your flight is boarding, please head to terminal: \(unwrappedTerminal ??? "TBD") immediately. The doors are closing soon.")
                    default:
                        print("We are experiencing technical issues and cannot retrieve your flight information. Please head to the nearest information desk for more details.")
                }
            }
        }
    }
}
//: ## 2. Create 3 flights and add them to a departure board
//: a. For the departure time, use `Date()` for the current time
//:
//: b. Use the Array `append()` method to add `Flight`'s
//:
//: c. Make one of the flights `.canceled` with a `nil` departure time
//:
//: d. Make one of the flights have a `nil` terminal because it has not been decided yet.
//:
//: e. Stretch: Look at the API for [`DateComponents`](https://developer.apple.com/documentation/foundation/datecomponents?language=objc) for creating a specific time
let airportLAXDestination = Airport(mIsDestination: true, mName: "Los Angeles")
let airportSNADestination = Airport(mIsDestination: true, mName: "Orange County")

// 1
let flight1 = Flight(mDepartureTime: Date.init(timeIntervalSinceNow: 432000),
                     mTerminal: "A1",
                     mDestination: airportLAXDestination,
                     mAirline: "Southwest Airlines",
                     mFlightStatus: FlightStatus.BOARDING,
                     mFlightNumber: "SW 854")


// 2
let flight2 = Flight(mDepartureTime: Calendar.autoupdatingCurrent.date(from: DateComponents.init(calendar: nil, timeZone: TimeZone.autoupdatingCurrent,
                                                                                                 era: nil, year: 2020, month: 8, day: 24, hour: 20,
                                                                                                 minute: 50, second: nil, nanosecond: nil, weekday: nil,
                                                                                                 weekdayOrdinal: nil, quarter: nil, weekOfMonth: nil,
                                                                                                 weekOfYear: nil, yearForWeekOfYear: nil)),
                     mTerminal: "B2",
                     mDestination: airportSNADestination,
                     mAirline: "Delta Airlines",
                     mFlightStatus: FlightStatus.CANCELED,
                     mFlightNumber: "DA 162")

// 3
var dateComponents = DateComponents()
dateComponents.year = 2020
dateComponents.month = 5
dateComponents.day = 11
dateComponents.timeZone = TimeZone.autoupdatingCurrent
dateComponents.hour = 11
dateComponents.minute = 30
let flight3 = Flight(mDepartureTime: Calendar.autoupdatingCurrent.date(from: dateComponents),
                     mTerminal: "C3",
                     mDestination: airportSNADestination,
                     mAirline: "American Airlines",
                     mFlightStatus: FlightStatus.SCHEDULED,
                     mFlightNumber: "AA 525")


var departureBoard = DepartureBoard([], Airport(mIsDestination: false, mName: "ONT - Ontario Airport"))
departureBoard.mDepartures.append(flight1)
departureBoard.mDepartures.append(flight2)
departureBoard.mDepartures.append(flight3)

// alternatively
// var departureBoard = DepartureBoard([flight1, flight2, flight3], Airport(mIsDestination: false))
//: ## 3. Create a free-standing function that can print the flight information from the `DepartureBoard`
//: a. Use the function signature: `printDepartures(departureBoard:)`
//:
//: b. Use a `for in` loop to iterate over each departure
//:
//: c. Make your `FlightStatus` enum conform to `String` so you can print the `rawValue` String values from the `enum`. See the [enum documentation](https://docs.swift.org/swift-book/LanguageGuide/Enumerations.html).
//:
//: d. Print out the current DepartureBoard you created using the function
func printDepartures(_ departureBoard: DepartureBoard) {
    let df = DateFormatter()
    df.timeStyle = .short
    df.dateStyle = .medium
    df.locale = Locale(identifier: "en_US")
    for departure in departureBoard.mDepartures {
        if let unwrappedDestination = departure.mDestination?.mName,
            let unwrappedAirline = departure.mAirline,
            let unwrappedFlightNumber = departure.mFlightNumber,
            let unwrappedDepartureTime = departure.mDepartureTime,
            let unwrappedTerminal = departure.mTerminal,
            let unwrappedFlightStatus = departure.mFlightStatus {
            
            print("Destination: \(unwrappedDestination) Airline: \(unwrappedAirline) Flight: \(unwrappedFlightNumber) Departure Time: \(df.string(from: unwrappedDepartureTime)), Terminal: \(unwrappedTerminal) Status: \(unwrappedFlightStatus)")
        }
    }
}


printDepartures(departureBoard)

//: ## 4. Make a second function to print print an empty string if the `departureTime` is nil
//: a. Createa new `printDepartures2(departureBoard:)` or modify the previous function
//:
//: b. Use optional binding to unwrap any optional values, use string interpolation to turn a non-optional date into a String
//:
//: c. Call the new or udpated function. It should not print `Optional(2019-05-30 17:09:20 +0000)` for departureTime or for the Terminal.
//:
//: d. Stretch: Format the time string so it displays only the time using a [`DateFormatter`](https://developer.apple.com/documentation/foundation/dateformatter) look at the `dateStyle` (none), `timeStyle` (short) and the `string(from:)` method
//:
//: e. Your output should look like:
//:
//:     Destination: Los Angeles Airline: Delta Air Lines Flight: KL 6966 Departure Time:  Terminal: 4 Status: Canceled
//:     Destination: Rochester Airline: Jet Blue Airways Flight: B6 586 Departure Time: 1:26 PM Terminal:  Status: Scheduled
//:     Destination: Boston Airline: KLM Flight: KL 6966 Departure Time: 1:26 PM Terminal: 4 Status: Scheduled



//: ## 5. Add an instance method to your `DepatureBoard` class (above) that can send an alert message to all passengers about their upcoming flight. Loop through the flights and use a `switch` on the flight status variable.
//: a. If the flight is canceled print out: "We're sorry your flight to \(city) was canceled, here is a $500 voucher"
//:
//: b. If the flight is scheduled print out: "Your flight to \(city) is scheduled to depart at \(time) from terminal: \(terminal)"
//:
//: c. If their flight is boarding print out: "Your flight is boarding, please head to terminal: \(terminal) immediately. The doors are closing soon."
//:
//: d. If the `departureTime` or `terminal` are optional, use "TBD" instead of a blank String
//:
//: e. If you have any other cases to handle please print out appropriate messages
//:
//: d. Call the `alertPassengers()` function on your `DepartureBoard` object below
//:
//: f. Stretch: Display a custom message if the `terminal` is `nil`, tell the traveler to see the nearest information desk for more details.
departureBoard.alertPassengers()

//: ## 6. Create a free-standing function to calculate your total airfair for checked bags and destination
//: Use the method signature, and return the airfare as a `Double`
//:
//:     func calculateAirfare(checkedBags: Int, distance: Int, travelers: Int) -> Double {
//:     }
//:
//: a. Each bag costs $25
//:
//: b. Each mile costs $0.10
//:
//: c. Multiply the ticket cost by the number of travelers
//:
//: d. Call the function with a variety of inputs (2 bags, 2000 miles, 3 travelers = $750)
//:
//: e. Make sure to cast the numbers to the appropriate types so you calculate the correct airfare
//:
//: f. Stretch: Use a [`NumberFormatter`](https://developer.apple.com/documentation/foundation/numberformatter) with the `currencyStyle` to format the amount in US dollars.
func calculateAirfare(_ checkedBags: Int, _ distance: Int, _ travelers: Int) -> Double {
    return ((Double(checkedBags) * 25.00) + (Double(distance) * 0.1)) * Double(travelers)
}

let nf = NumberFormatter()
nf.numberStyle = .currency
nf.locale = Locale.current
print(nf.string(from: calculateAirfare(2, 2000, 3) as NSNumber)!)
