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

// Formatting helper class
private class Formatter {
    private let dateFormatter: DateFormatter
    private let currencyFormatter: NumberFormatter
    private static let std: Formatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .short
        
        let currencyFormatter = NumberFormatter()
        currencyFormatter.numberStyle = .currency
        currencyFormatter.currencySymbol = "$"
        
        return Formatter(dateFormatter: dateFormatter, currencyFormatter: currencyFormatter)
    }()
    
    private init(dateFormatter: DateFormatter, currencyFormatter: NumberFormatter) {
        self.dateFormatter = dateFormatter
        self.currencyFormatter = currencyFormatter
    }
    
    static func date(_ date: Date?, _ fallback: String = "") -> String {
        if let date = date {
            return std.dateFormatter.string(from: date)
        }
        return fallback
    }
    
    static func currency(_ value: Double) -> String {
        let num = NSNumber(value: value)
        let result = std.currencyFormatter.string(from: num)
        return result ?? ""
    }
}


enum FlightStatus: String {
    case scheduled = "Scheduled"
    case canceled = "Canceled"
    case delayed = "Delayed"
    case boarding = "Boarding"
    case enRoute = "En Route"
    case landed = "Landed"
}

struct Airport {
    let name: String
    let location: String
    
    init(name: String, location: String) {
        self.name = name
        self.location = location
    }
}

struct Flight {
    let departure: Airport
    let arrival: Airport
    var departureTime: Date?
    var terminal: String?
    var status: FlightStatus
}


class DepartureBoard {
    let airport: Airport
    var flights: [Flight]
    
    init(airport: Airport, flights: [Flight]? = nil) {
        self.airport = airport
        self.flights = flights ?? Array<Flight>()
    }
    
    func alertPassengers() {
        print("\(airport.name) alert system:")
        
        func formatTerminal(_ flight: Flight) -> String {
            return flight.terminal ?? "The terminal for this flight has not been determined yet. Please see your nearest help desk for more info."
        }
        for flight in flights {
            switch flight.status {
            case .scheduled:
                print("Your flight to \(flight.arrival.location) is scheduled to depart at \(Formatter.date(flight.departureTime, "TBD")), from terminal: \(formatTerminal(flight))")
            case .canceled:
                print("We're sorry your flight to \(flight.arrival.location) was canceled, please see your nearest help desk to collect a $500 voucher")
            case .delayed:
                print("We're sorry, your flight to \(flight.arrival.location) has been delayed, stand by for a new departure time.")
            case .boarding:
                print("Your flight is boarding, please head to terminal: \(formatTerminal(flight)) immediately. The doors are closing soon.")
            case .enRoute:
                print("The flight to \(flight.arrival.location) is currently en route. If you've missed it, please see your nearest help desk to reschedule.")
            case .landed:
                print("The flight to \(flight.arrival.location) has now landed.")
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

let jfkAirport = Airport(name: "JFK Airport", location: "Queens, NY")
let bostonAirport = Airport(name: "Boston Airport", location: "Boston, MA")
let seoulAirport = Airport(name: "Seoul Airport", location: "Seoul, South Korea")
let charlotteAirport = Airport(name: "Charlotte Airport", location: "Charlotte, NC")

let jfkToBostonFlight = Flight(
    departure: jfkAirport,
    arrival: bostonAirport,
    departureTime: Calendar.current.date(from: DateComponents(
        timeZone: TimeZone(abbreviation: "EST"),
        year: 2020,
        month: 2,
        day: 2,
        hour: 12
    )),
    terminal: "5",
    status: .landed
)

let jfkToSeoulFlight = Flight(
    departure: jfkAirport,
    arrival: seoulAirport,
    departureTime: nil,
    terminal: "1",
    status: .canceled
)

let jfkToCharlotteFlight = Flight(
    departure: jfkAirport,
    arrival: charlotteAirport,
    departureTime: Date(),
    terminal: nil,
    status: .scheduled
)

let board = DepartureBoard(airport: jfkAirport)
board.flights.append(jfkToBostonFlight)
board.flights.append(jfkToSeoulFlight)
board.flights.append(jfkToCharlotteFlight)


//: ## 3. Create a free-standing function that can print the flight information from the `DepartureBoard`
//: a. Use the function signature: `printDepartures(departureBoard:)`
//:
//: b. Use a `for in` loop to iterate over each departure
//:
//: c. Make your `FlightStatus` enum conform to `String` so you can print the `rawValue` String values from the `enum`. See the [enum documentation](https://docs.swift.org/swift-book/LanguageGuide/Enumerations.html).
//:
//: d. Print out the current DepartureBoard you created using the function

func printDepartures(board: DepartureBoard) {
    print("Departures for \(board.airport.name):")
    for flight in board.flights {
        print("Destination: \(flight.arrival.name) | Departure Time: \(String(describing: flight.departureTime)) | Terminal: \(String(describing: flight.terminal)) | Status: \(flight.status.rawValue)")
    }
}

printDepartures(board: board)


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

func printDepartures2(board: DepartureBoard) {
    print("Departures for \(board.airport.name):")
    for flight in board.flights {
        print("Destination: \(flight.arrival.name) | Departure Time: \(Formatter.date(flight.departureTime)) | Terminal: \(flight.terminal ?? "") | Status: \(flight.status.rawValue)")
    }
}

printDepartures2(board: board)


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

board.alertPassengers()


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

func calculateAirfare(checkedBags: Int, distance: Int, travelers: Int) -> Double {
    return (Double(checkedBags * 25) + Double(distance / 10)) * Double(travelers)
}


print(Formatter.currency(calculateAirfare(checkedBags: 4, distance: 2000, travelers: 10)))
print(Formatter.currency(calculateAirfare(checkedBags: 5, distance: 1500, travelers: 5)))

