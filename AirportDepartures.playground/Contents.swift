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
    case onTime = "On Time"
    case scheduled = "Scheduled"
    case cancelled = "Cancelled"
    case delayed = "Delayed"
    case landed = "Landed"
    case boarding = "Boarding"
}

struct Airport {
    var name: String
    var city: String
    var code: String
}

struct Flight {
    var destination: Airport
    var number: String
    var airline: String
    var departTime: Date?
    var terminal: String?
    var status: FlightStatus
}

class DepartureBoard {
    var airport: Airport
    var flights: [Flight]
    
    init(airport: Airport) {
        self.airport = airport
        flights = []
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
//Airports
let orlando = Airport(name: "Orlando International Airport", city: "Orlando", code: "MCO")
let dallas = Airport(name: "Dallas/Fort Worth", city: "Dallas", code: "DFW")
let nashville = Airport(name: "Nashville Airport", city: "Nashville", code: "BNA")


//Flights
let toOrlando = Flight(destination: orlando, number: "AF 2905", airline: "Air France", departTime: nil, terminal: "2", status: .boarding)
let toDallas = Flight(destination: dallas, number: "9E 3476", airline: "Endeavor Air", departTime: Date(), terminal: nil, status: .delayed)
let toNashville = Flight(destination: nashville, number: "MQ 3829", airline: "Envoy Air", departTime: Date(), terminal: "8", status: .onTime)

//Initializing
let newYorkCity = Airport(name: "John F. Kennedy", city: "New York City", code: "JFK")

let jfk = DepartureBoard(airport: newYorkCity)

jfk.flights.append(toDallas)
jfk.flights.append(toNashville)
jfk.flights.append(toOrlando)



//: ## 3. Create a free-standing function that can print the flight information from the `DepartureBoard`
//: a. Use the function signature: `printDepartures(departureBoard:)`
//:
//: b. Use a `for in` loop to iterate over each departure
//:
//: c. Make your `FlightStatus` enum conform to `String` so you can print the `rawValue` String values from the `enum`. See the [enum documentation](https://docs.swift.org/swift-book/LanguageGuide/Enumerations.html).
//:
//: d. Print out the current DepartureBoard you created using the function
func printDepartures(departureBoard: DepartureBoard) {
    for flight in departureBoard.flights {
        print("Destination: \(flight.destination.city)\tAirline: \(flight.airline)\tFlight #: \(flight.number)\tTime: \(String(describing: flight.departTime)))\tTerminal: \(String(describing: flight.terminal)))\tStatus: \(flight.status.rawValue)")
    }
}

printDepartures(departureBoard: jfk)




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
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .none
    dateFormatter.timeStyle = .short
    
    for flight in departureBoard.flights {
        print("Destination: \(flight.destination.city)\tAirline: \(flight.airline)\tFlight: \(flight.number)", terminator: "")
        print("\tDeparture Time: ", terminator: "")
        if let dateTime: Date = flight.departTime { print("\(dateFormatter.string(from: dateTime))", terminator: "") }
        print("\tTerminal: ", terminator: "")
        if let terminal: String = flight.terminal { print("\(terminal)", terminator: "") }
        print("\tStatus: \(flight.status.rawValue)")
    }
}

printDepartures2(departureBoard: jfk)

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
extension DepartureBoard {
    func alertPassengers() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .short
        
        for flight in flights {
            
            switch flight.status {
            case .enRoute:
                print("Your flight is \(flight.status.rawValue) and on time.")
            case .onTime:
                print("Your flight will be arriving/departing \(flight.status.rawValue).")
            case .scheduled:
                let dateTime: String = dateFormatter.string(from: flight.departTime ?? Date())
                let terminal: String = flight.terminal ?? "TBD"
                var time: String = ""
                if flight.departTime == nil {
                    time = "TBD"
                    print("Your flight to \(flight.destination.city) is scheduled to depart at \(time) from terminal: \(String(describing: terminal))")
                } else {
                    print("Your flight to \(flight.destination.city) is scheduled to depart at \(dateTime) from terminal: \(String(describing: terminal))")
                }
            case .cancelled:
                print("We're sorry your flight to \(flight.destination.city) was cancelled, here is a $500 voucher")
            case .delayed:
                print("We're sorry, your flight has been \(flight.status.rawValue). Stay tuned for more updates.")
            case .landed:
                print("Your flight has \(flight.status.rawValue)")
            case .boarding:
                if let terminal: String = flight.terminal {
                    print("Your flight is \(flight.status.rawValue), please head to terminal: \(String(describing: terminal)) immediately. The doors are closing soon.")
                } else {
                    let terminal = "TBD"
                    print("Your flight is \(flight.status.rawValue), please head to terminal: \(String(describing: terminal)) immediately. The doors are closing soon.")
                }
            }
        }
    }
}


jfk.alertPassengers()




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
    
    let bagCost: Double = 25.0
    let mileCost: Double = 0.10
    let ticketCost: Double = 250
    
    let totalTickets = Double(travelers) * ticketCost
    let totalBags = Double(checkedBags) * bagCost
    let totalDistance = Double(distance) * mileCost
    
    let totalAirfareCost = totalTickets + totalBags + totalDistance
    
    return totalAirfareCost
}

let numberFormatter = NumberFormatter()
numberFormatter.usesGroupingSeparator = true
numberFormatter.numberStyle = .currency
numberFormatter.locale = Locale.current

if let calculatedAirfare = numberFormatter.string(from: NSNumber(value: calculateAirfare(checkedBags: 2, distance: 2000, travelers: 3)))
{
    print("Your total airfare is: \(calculatedAirfare).")
}

if let calculatedAirfare = numberFormatter.string(from: NSNumber(value: calculateAirfare(checkedBags: 5, distance: 10_000, travelers: 2)))
{
    print("Your total airfare is: \(calculatedAirfare).")
}



