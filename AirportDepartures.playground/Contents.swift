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
    case enRoute = "En Route"
    case scheduled = "Scheduled"
    case canceled = "Canceled"
    case delayed = "Delayed"
}

struct Airport {
    var city: String
    var code: String

}
struct Flight {
    var airline: String
    var depart: Date?
    var terminal: String?
    var status: FlightStatus
    var destination: Airport
    var flight: String
    
}
class DepartureBoard {
    var airport: Airport
    var departures: [Flight]
    
    init(city: String, code: String) {
        airport = Airport(city: city, code: code)
        departures = []
    }
    func alertPassengers() {
        for flight in departures {
            
            var timeString = "TBD"
            if let time = flight.depart {
                timeString = "\(time)"
            }
            var terminalString = "TBD"
            if let terminal = flight.terminal {
                terminalString = "\(terminal)"
        }
            switch flight.status {
            case .canceled:
                print ("We're sorry your flight to \(flight.destination.city) was canceled, here is a $500 voucher")
            case .scheduled:
                print("Your flight to \(flight.destination.city) is scheduled to depart at (time) from terminal: \(terminalString)")
            case .enRoute:
                print ("Your flight is en Route")
            case .delayed:
                print ("Your flight has been delayed")
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
let orl = Airport(city: "Orlando", code: "ORL")
let tlh = Airport(city: "Tallahassee", code: "TLH")
let tma = Airport(city: "Tampa", code: "TMA")


let orlandoFlight = Flight(airline: "Delta" , depart: nil, terminal: nil, status: .canceled, destination: orl, flight: "1321")
let tallahasseeFlight = Flight(airline: "Delta", depart: Date(), terminal: "33", status: .scheduled, destination: tlh, flight: "3123")
let tampaFlight = Flight(airline: "Delta", depart: Date(), terminal: "21", status: .enRoute, destination: tma, flight: "3812")

let SarasotaDepartureBoard = DepartureBoard(city:"sarasota", code: "SRQ")
SarasotaDepartureBoard.departures.append(orlandoFlight)
SarasotaDepartureBoard.departures.append(tampaFlight)
SarasotaDepartureBoard.departures.append(tallahasseeFlight)



//: ## 3. Create a free-standing function that can print the flight information from the `DepartureBoard`
//: a. Use the function signature: `printDepartures(departureBoard:)`
//:
//: b. Use a `for in` loop to iterate over each departure
//:
//: c. Make your `FlightStatus` enum conform to `String` so you can print the `rawValue` String values from the `enum`. See the [enum documentation](https://docs.swift.org/swift-book/LanguageGuide/Enumerations.html).
//:
//: d. Print out the current DepartureBoard you created using the function
func printDepartures(departureBoard: DepartureBoard) {
    
    for flight in departureBoard.departures {
            var timeString = "TBD"
            if let time = flight.depart {
                timeString = "\(time)"
            }
            var terminalString = "TBD"
            if let terminal = flight.terminal {
                terminalString = "\(terminal)"
        }
    
        print ("DESTINATION: \(flight.destination.city) AIRLINE: \(flight.airline) FLIGHT: \(flight.flight) DEPARTURE TIME: \(timeString) TERMINAL: \(terminalString) STATUS: \(flight.status.rawValue)")
}
}

printDepartures(departureBoard: SarasotaDepartureBoard)



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
printDepartures




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
func calculateAirfare(checkedBag: Int, distance: Int, travelers: Int) -> Double {
    let total = (Double(checkedBag) * 25 + Double(distance) * 0.1) * Double(travelers)
return total
}

print("Your checked bag fee: $\(calculateAirfare(checkedBag: 2, distance: 3030, travelers: 2))")
