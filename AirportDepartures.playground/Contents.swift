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
// type of the flight status
enum FlightStatus: String {
    case enRoute
    case scheduled
    case canceled
    case delayed
    case boarding
}

// name of the airport
struct Airport {
    let destination: String
    let arrival: String
}

// flight information
struct Flight {
    var name: String
    var flightNumber: String
    var airport: Airport
    var date: Date?
    var terminal: String?
    var flightStatus: FlightStatus
    
    var readableTerminal: String {
        guard let terminal = self.terminal else { return "see the nearest information desk for more details."}
        return terminal
    }
    
    // formatting the date to be readable in the alert messages
    var readableDate: String {
        guard let date = date else { return "TBD" }
        return formatter.string(from: date)
    }
}

// formatting the date
let formatter = DateFormatter()
formatter.dateStyle = .none
formatter.timeStyle = .short

// departure board
class DepartureBoard {
    var departureFlights: [Flight]
    let name: String
    
    init(name: String) {
        self.departureFlights = []
        self.name = name
    }
    
    // sending alert messages to passengers based on their flight status
    func alertPassengers(flight: Flight) {
        switch flight.flightStatus {
        case .canceled:
            print("We're sorry your flight to \(flight.airport.destination) was canceled, here is a $500 voucher")
        case .scheduled:
            print("Your flight to \(flight.airport.destination) is scheduled to depart at \(flight.readableDate) from terminal: \(flight.readableTerminal)")
        case .boarding:
            print("Your flight is boarding, please head to terminal: \(flight.terminal ?? "TBD") immediately. The doors are closing soon.")
        case .delayed:
            print("Your flight is delayed, please check with the terminal agent for more information.")
        default:
            print("Your flight is delayed")
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
// creating a date component for the 3 flights
let dateComponent = DateComponents(year: 2019, month: 07, day: 19, hour: 19, minute: 23, second: 10)
guard let departureDate = Calendar.current.date(from: dateComponent) else { fatalError() }
let tomorrowDate = Calendar.current.date(byAdding: .day, value: 1, to: departureDate)


// creating 3 flights as examples
var virginAtlantic = Flight(name: "Virgin Atlantic", flightNumber: "VS 4", airport: Airport(destination: "London (LHR)", arrival: "New York (JFK)"), date: departureDate, terminal: "4", flightStatus: .enRoute)
var qantas = Flight(name: "Qantas", flightNumber: "QF 12", airport: Airport(destination: "Los Angeles (LAX)", arrival: "New York (JFK)"), date: departureDate, terminal: "8", flightStatus: .delayed)
var delta = Flight(name: "Delta Air Lines", flightNumber: "DL 4373", airport: Airport(destination: "London (LHR)", arrival: "New York (JFK)") , date: departureDate, terminal: "4", flightStatus: .scheduled)
var united = Flight(name: "United Air Lines", flightNumber: "UA909", airport: Airport(destination: "New Jersey (EWR)", arrival: "New York (JKF)"), date: departureDate, terminal: nil, flightStatus: .scheduled)

// creating JFK Departure Board and adding the 3 flights
let jfkDepartureBoard = DepartureBoard(name: "JFK")
jfkDepartureBoard.departureFlights.append(delta)
jfkDepartureBoard.departureFlights.append(qantas)
jfkDepartureBoard.departureFlights.append(virginAtlantic)

// alerting passengers for their flight status
jfkDepartureBoard.alertPassengers(flight: delta)
jfkDepartureBoard.alertPassengers(flight: qantas)
jfkDepartureBoard.alertPassengers(flight: united)

// changing delta flight status to canceled with a nil departure time
delta.flightStatus = .canceled
delta.terminal = nil
delta.date = tomorrowDate
//: ## 3. Create a free-standing function that can print the flight information from the `DepartureBoard`
//: a. Use the function signature: `printDepartures(departureBoard:)`
//:
//: b. Use a `for in` loop to iterate over each departure
//:
//: c. Make your `FlightStatus` enum conform to `String` so you can print the `rawValue` String values from the `enum`. See the [enum documentation](https://docs.swift.org/swift-book/LanguageGuide/Enumerations.html).
//:
//: d. Print out the current DepartureBoard you created using the function
// print the flight info
func printDepartures(departureBoard: DepartureBoard) {
    for flight in departureBoard.departureFlights {
        guard let date = flight.date else { return }
        print("Destination: \(flight.airport.destination))\nAirline: \(flight.name))\nFlight: \(flight.flightNumber))\nDeparture Time: \(formatter.string(from:date))\nTerminal: \(flight.terminal ?? "No Terminal")\nStatus: \(flight.flightStatus.rawValue)\n")
    }
}

printDepartures(departureBoard: jfkDepartureBoard)



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
// the answer is above


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
// the answer is above



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
// calculating total airfare based on the number of travelers, checked bags and miles
func calculateAirfare(checkedBags: Int, distance: Int, travelers: Int) -> Double {
    let bagFee = 25.00
    let mileFee = 0.10
    let ticketCost = 250.00
    
    return (Double(travelers) * ticketCost) + (Double(checkedBags) * bagFee) + (Double(distance) * mileFee)
}

let numberFormatter = NumberFormatter()
numberFormatter.numberStyle = .currency
numberFormatter.locale = Locale.current

let airfare = calculateAirfare(checkedBags: 2, distance: 2000, travelers: 3)
let airfareString = numberFormatter.string(from: NSNumber(value: airfare))

