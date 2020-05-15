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
    case scheduled = "Scheduled"
    case canceled = "Canceled"
    case enRoute = "En Route"
    case landed = "Landed"
    case boarding = "Boarding"
    case departed = "Departed"
}

enum Timing: String {
    case onTime = " - On Time"
    case delayed = " - Delayed"
    case early = " - Early"
}

struct Airport {
    let name: String
    let abbreviation: String
    let location: String
}

struct Flight {
    let airline: String
    let number: String
    let destination: Airport
    var terminal: String?
    var departureTime: String?
    var status: (FlightStatus, Timing?)
}

class DepartureBoard {
    var airport: Airport
    var departures: [Flight]
    
    init(airport: Airport) {
        self.airport = airport
        self.departures = []
    }
    
    func alertPassengers() {
        for flight in departures {
            if flight.terminal == nil {
                print("Please see the nearest information desk about \(flight.airline) Flight \(flight.number) to \(flight.destination.name).")
            } else {
                switch flight.status.0 {
                case .scheduled:
                    print("\(flight.airline) Flight \(flight.number) to \(flight.destination.name) is scheduled to depart at \(flight.departureTime ?? "TBD") from Terminal: \(flight.terminal ?? "TBD")")
                case .canceled:
                    print("We're sorry \(flight.airline) Flight \(flight.number) to \(flight.destination.name) was canceled, here is a $500 voucher.")
                case .enRoute:
                    print("\(flight.airline) Flight \(flight.number) is en route, and scheduled to land at Terminal: \(flight.terminal ?? "TBD")")
                case .landed:
                    print("\(flight.airline) Flight \(flight.number) has landed at Terminal: \(flight.terminal ?? "TBD")")
                case .boarding:
                    print("\(flight.airline) Flight \(flight.number) is boarding, please head to Terminal: \(flight.terminal ?? "TBD") immediately. The doors are closing soon.")
                case .departed:
                    print("\(flight.airline) Flight \(flight.number) has departed from Terminal: \(flight.terminal ?? "unknown")")
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
let jfk = Airport(name: "John F. Kennedy International", abbreviation: "JFK", location: "New York")
var jfkDepartures = DepartureBoard(airport: jfk)

let lax = Airport(name: "Los Angeles International", abbreviation: "LAX", location: "California")
let hel = Airport(name: "Helsinki Airport", abbreviation: "HEL", location: "Finland")
let bos = Airport(name: "Boston Logan Airport", abbreviation: "BOS", location: "Massachussetts")
let buf = Airport(name: "Buffalo Airport", abbreviation: "BUF", location: "New York")

func time(hour: Int, minute: Int) -> String {
    var timeComponents = DateComponents()
    timeComponents.hour = hour
    timeComponents.minute = minute
    let userCalendar = Calendar.current
    let time = userCalendar.date(from: timeComponents)
    if let unwrappedTime = time {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: unwrappedTime)
    } else {
        return "TBD"
    }
}

var aa302 = Flight(airline: "American Airlines", number: "AA 302", destination: lax, terminal: nil, departureTime: nil, status: (.canceled, nil))
jfkDepartures.departures.append(aa302)

var ay6 = Flight(airline: "Finnair", number: "AY 6", destination: hel, terminal: nil, departureTime: time(hour: 18, minute: 30), status: (.enRoute, .onTime))
jfkDepartures.departures.append(ay6)

var dl5675 = Flight(airline: "Delta Air Lines", number: "DL 5675", destination: bos, terminal: "4", departureTime: time(hour: 19, minute: 00), status: (.landed, .early))
jfkDepartures.departures.append(dl5675)

var b62002 = Flight(airline: "JetBlue Airlines", number: "B 62002", destination: buf, terminal: "5", departureTime: time(hour: 18, minute: 10), status: (.boarding, .delayed))
jfkDepartures.departures.append(b62002)
//: ## 3. Create a free-standing function that can print the flight information from the `DepartureBoard`
//: a. Use the function signature: `printDepartures(departureBoard:)`
//:
//: b. Use a `for in` loop to iterate over each departure
//:
//: c. Make your `FlightStatus` enum conform to `String` so you can print the `rawValue` String values from the `enum`. See the [enum documentation](https://docs.swift.org/swift-book/LanguageGuide/Enumerations.html).
//:
//: d. Print out the current DepartureBoard you created using the function
func printDepartures(departureBoard: DepartureBoard) {
    print("Departures for \(jfkDepartures.airport.abbreviation) - \(jfkDepartures.airport.name) in \(jfkDepartures.airport.location)")
    for flight in jfkDepartures.departures {
        print("Destination: \(flight.destination.name) - \(flight.destination.abbreviation)  Airline: \(flight.airline)  Flight #: \(flight.number)  Departure Time: \(String(describing: flight.departureTime))  Terminal: \(flight.terminal ?? "")  Status: \(flight.status.0.rawValue)\(flight.status.1?.rawValue ?? "")")
    }
}

printDepartures(departureBoard: jfkDepartures)
print("")
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
func printDepartures2(departureBoard: DepartureBoard) {
    print("Departures for \(jfkDepartures.airport.abbreviation) - \(jfkDepartures.airport.name) in \(jfkDepartures.airport.location)")
    for flight in jfkDepartures.departures {
        var time = ""
        var terminal = ""
        if let flightTime = flight.departureTime {
            time = flightTime
            if let flightTerminal = flight.terminal {
                terminal = flightTerminal
            }
        }
    print("Destination: \(flight.destination.name) - \(flight.destination.abbreviation)  Airline: \(flight.airline)  Flight #: \(flight.number)  Departure Time: \(time)  Terminal: \(terminal)  Status: \(flight.status.0.rawValue)\(flight.status.1?.rawValue ?? "")")
    }
}

printDepartures2(departureBoard: jfkDepartures)
print("")
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
jfkDepartures.alertPassengers()
print("")
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
func calculateAirfare(checkedBags: Int, distance: Int, travelers: Int) -> String {
    let airfare = ((Double(checkedBags) * 25) + (Double(distance) * 0.10)) * Double(travelers)
    let formatter = NumberFormatter()
    formatter.numberStyle = .currency
    if let formattedAirfare = formatter.string(for: airfare) {
        return formattedAirfare
    } else {
        return "invalid input"
    }
}

print(calculateAirfare(checkedBags: 2, distance: 2000, travelers: 3))
print(calculateAirfare(checkedBags: 1, distance: 1500, travelers: 2))
print(calculateAirfare(checkedBags: 3, distance: 3000, travelers: 4))
