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
enum flightStatus {
    case EnRoute
    case Scheduled
    case Canceled
    case Delayed
    case Landed
}

struct Airport {
    var destination: String
}

struct Flight {
    let flightName: String
    let airline: String
    let departureTime: Date?
    let terminal: String?
    let flightStatus: flightStatus
    let destination: Airport
}

class DepartureBoard {
    var flights: [Flight]
    var currentAirport: Airport
    
    init(currentAirport: String) {
        self.currentAirport = Airport(destination: "Georgetown")
        self.flights = []
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


let flight1 = Flight(flightName: "AA2896",
                     airline: "American Airlines",
                     departureTime: Date(),
                     terminal: nil,
                     flightStatus: .EnRoute,
                     destination: Airport(destination: "Georgetown"))

let flight2 = Flight(flightName: "QF12",
                     airline: "Qantas",
                     departureTime: nil,
                     terminal: nil,
                     flightStatus: .Canceled,
                     destination: Airport(destination: "Los Angeles"))

let flight3 = Flight(flightName: "AY5747",
                     airline: "Finnair",
                     departureTime: Date(),
                     terminal: "8",
                     flightStatus: .EnRoute,
                     destination: Airport(destination: "San Fransisco"))

let departureBoard = DepartureBoard(currentAirport: "JFK Airport")

departureBoard.flights.append(flight1)
departureBoard.flights.append(flight2)
departureBoard.flights.append(flight3)

//: ## 3. Create a free-standing function that can print the flight information from the `DepartureBoard`
//: a. Use the function signature: `printDepartures(departureBoard:)`
//:
//: b. Use a `for in` loop to iterate over each departure
//:
//: c. Make your `FlightStatus` enum conform to `String` so you can print the `rawValue` String values from the `enum`. See the [enum documentation](https://docs.swift.org/swift-book/LanguageGuide/Enumerations.html).
//:
//: d. Print out the current DepartureBoard you created using the function
func printDepartures(departureBoard: DepartureBoard) {
    for departure in departureBoard.flights {
        print(departure)
    }
}

printDepartures(departureBoard: departureBoard)

// Not done with question 3. Keep working on it!

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



