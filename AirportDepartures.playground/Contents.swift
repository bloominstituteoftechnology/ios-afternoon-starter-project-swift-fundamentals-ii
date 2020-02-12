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
enum FlightStatus: String {
    case enRoute // For flights currently travelling to or from destination/arrival
    case scheduled //For future-dated flights that have not departed
    case canceled //For flights that have been ground for x reasons
    case delayed //Flights that have missed their initial departure time but still have plans of departing
    case landed //Flights that have arrived to the destination/arrival terminal
    case onTime //Flights that are set to leave at currently scheduled time but have not initiated flight yet
    case diverted //Flights that have changed course of orignal flight plan due to x reason
}

struct Airport {
    var destination: String //where the flight is traveling to
    var arrival: String //where the plane has entered a terminal for a scheduled depature
}

struct Flight {
    var date: Date? // the date and time the flight is scheduled to depart
    var terminal: String? // the terminal or gate the flight is departing from
    var flightNumber: String? //the tail number of the flight in order to track it
    var airlineName: String? //the name of the airline carrier
    var currentFlightStatus: FlightStatus
}

//class DepartureBoard {
//    var departureFlights: String //current flights scheduled to leave organized by first out; use tail number
//    var currentAirport: String //where the flight is currently located
//
//
//    init(departureFlights: String, currentAirport: String) {
//        self.departureFlights = departureFlights
//        self.currentAirport = currentAirport
//    }
//
//}

struct DateComponents {
    var timeZone: TimeZone? = nil
    var calendar: Calendar? = nil
}

class DepartureBoard {
    var departureFlights: [Airport]
    var flightInformation: [Flight]
    
    init(departureFlights: Airport, flightInformation: Flight) {
        self.departureFlights = []
        self.flightInformation = []
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
var myFlight = DepartureBoard(departureFlights: .init(destination: "Los Angeles", arrival: "Philadelphia"), flightInformation: .init(date: Date(), terminal: "C4", flightNumber: "KL642", airlineName: "American Airlines", currentFlightStatus: .onTime))

var canceledFlight = DepartureBoard(departureFlights: .init(destination: "Paris", arrival: "New York"), flightInformation: .init(date: nil, terminal: nil, flightNumber: nil, airlineName: "Air France", currentFlightStatus: .canceled))

var landedFlight = DepartureBoard(departureFlights: .init(destination: "Phoenix", arrival: "Seattle"), flightInformation: .init(date: Date(), terminal: nil, flightNumber: "MU4544", airlineName: "Delta Airlines", currentFlightStatus: .landed))


//: ## 3. Create a free-standing function that can print the flight information from the `DepartureBoard`
//: a. Use the function signature: `printDepartures(departureBoard:)`
//:
//: b. Use a `for in` loop to iterate over each departure
//:
//: c. Make your `FlightStatus` enum conform to `String` so you can print the `rawValue` String values from the `enum`. See the [enum documentation](https://docs.swift.org/swift-book/LanguageGuide/Enumerations.html).
//:
//: d. Print out the current DepartureBoard you created using the function
func printDepartures(departureBoard: ) {
    for 
}



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



