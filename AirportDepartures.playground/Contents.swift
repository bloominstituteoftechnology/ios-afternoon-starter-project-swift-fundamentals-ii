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
    case unknown = "Unknown"
    case scheduled = "Scheduled"
    case boarding = "Boarding"
    case departed = "Departed"
    case enroute = "En Route"
    case landed = "Landed"
    case arrived = "Arrived"
    case canceled = "Canceled"
    case delayed = "Delayed"
}

// ICAO airline designator
enum Airline: String {
    case unknown = "Unknown"
    case AAL = "American"
    case SWA = "Southwest"
    case UAL = "United"
    case NKS = "Spirit"
}

// IATA airport code
enum AirportIataCode: String {
    case BOS = "Logan International Airport"
    case JFK = "John F. Kennedy International Airport"
    case SFO = "San Francisco International Airport"
    case SJC = "San Jose International Airport"
}

struct Airport {
    var airport: AirportIataCode
    var time: Date?
    var terminal: String?
}

struct Flight {
    var airline: Airline
    var status: FlightStatus
    var flightNumber: String

    var departure: Airport
    var arrival: Airport
}

class DepartureBoard {
    var flights: [Flight]

    func addFlight(_ flight: Flight)
    {
        flights.append(flight)
    }
    
    init(_ flights: [Flight]) {
        self.flights = flights
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
var aFlight = Flight(airline: .AAL, status: .arrived, flightNumber: "617",
                     departure: Airport(airport: .JFK, time: Date(), terminal: "A"),
                     arrival: Airport(airport: .BOS, time: Date(), terminal: "5"))
var theBoard = DepartureBoard([aFlight])

// Canceled flight
aFlight = Flight(airline: .UAL, status: .canceled, flightNumber: "415",
                 departure: Airport(airport: .JFK, time: nil, terminal: nil),
                    arrival: Airport(airport: .SFO, time: nil, terminal: nil))

theBoard.addFlight(aFlight)

// Enroute and no terminal yet
aFlight = Flight(airline: .SWA, status: .enroute, flightNumber: "408",
                 departure: Airport(airport: .JFK, time: Date(), terminal: "B"),
                 arrival: Airport(airport: .SJC, time: Date(), terminal: nil))

theBoard.addFlight(aFlight)

//: ## 3. Create a free-standing function that can print the flight information from the `DepartureBoard`
//: a. Use the function signature: `printDepartures(departureBoard:)`
//:
//: b. Use a `for in` loop to iterate over each departure
//:
//: c. Make your `FlightStatus` enum conform to `String` so you can print the `rawValue` String values from the `enum`. See the [enum documentation](https://docs.swift.org/swift-book/LanguageGuide/Enumerations.html).
//:
//: d. Print out the current DepartureBoard you created using the function
print("")
print("Step 3")
print("")

func printDepartures(_ departureBoard: DepartureBoard) {
    print("Destination\tAirline\tFlight\tDeparture\tTerminal\tStatus")
    for flight in departureBoard.flights {
        let airport = flight.arrival.airport.rawValue
        let terminal = flight.departure.terminal
        let status = flight.status.rawValue
        let airline = flight.airline.rawValue
        let time = flight.departure.time?.description
        print("\(airport)\t\(airline)\t\(flight.flightNumber)\t\(String(describing: time))\t\(String(describing: terminal))\t\(status)")
    }
}

printDepartures(theBoard)

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
print("")
print("Step 4")
print("")

func saneTime(_ dateToFormat: Date?) -> String {
    guard let date = dateToFormat else {
        return "TBD"
    }

    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "h:mm a"
    let result = dateFormatter.string(from: date)
    
    return result
}

func printDepartures2(_ departureBoard: DepartureBoard) {

    for flight in departureBoard.flights {
        let airport = flight.arrival.airport.rawValue
        let terminal = flight.departure.terminal ?? "?"
        let status = flight.status.rawValue
        let airline = flight.airline.rawValue
        let time = saneTime(flight.departure.time)
        
        print("Destination: \(airport)", terminator: " ")
        print("Airline: \(airline)", terminator: " ")
        print("Flight: \(flight.flightNumber)", terminator: " ")
        print("Departure Time: \(time)", terminator: " ")
        print("Terminal: \(terminal)", terminator: " ")
        print("Status: \(status)")
    }
}

printDepartures2(theBoard)


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
print("")
print("Step 5")
print("")

extension DepartureBoard {
    func alertPassengers() {
        var msg: String
        
        for flight in flights {
            let terminal = flight.departure.terminal ?? "TBD"

            var supplimentalMsg = ""
            if terminal == "" {
                supplimentalMsg = " See the nearest information desk for more details."
            }
            
            switch flight.status {
            case .unknown:
                let flightNumber = flight.flightNumber
                let airport = flight.arrival.airport.rawValue
                msg = "No flight status available for flight \(flightNumber) to \(airport)"
            case .scheduled:
                let time = saneTime(flight.departure.time)
                let airport = flight.arrival.airport.rawValue
                msg = "Your flight to \(airport) is scheduled to depart at \(time) from terminal:\(terminal)"
            case .boarding:
                msg = "Your flight is boarding, please head to terminal: \(terminal) immediately. The doors are closing soon."
            case .departed:
                let airport = flight.arrival.airport.rawValue
                msg = "Your flight to \(airport) has departed."
            case .enroute:
                let airport = flight.arrival.airport.rawValue
                let time = saneTime(flight.arrival.time)
                msg = "Your flight will arrive at \(airport) at \(time)"
            case .landed:
                msg = "Your arrival terminal is \(terminal)"
            case .arrived:
                msg = "Your have arrived at terminal \(terminal)"
            case .canceled:
                let airport = flight.arrival.airport.rawValue
                msg = "We're sorry your flight to \(airport) was canceled, here is a $500 voucher"
            case .delayed:
                let airport = flight.arrival.airport.rawValue
                msg = "Your flight \(airport) is delayed."
            }
            print(msg + supplimentalMsg)
        }
    }
}

theBoard.alertPassengers()

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
print("")
print("Step 6")
print("")

func calculateAirfare(checkedBags: Int, distance: Int, travelers: Int) -> Double {
    let bags = 25.0 * Double(checkedBags)
    let milesCost = 0.10 * Double(distance)
    let finalCost = (bags + milesCost) * Double(travelers)
    
    return finalCost
}

let airfare = calculateAirfare(checkedBags: 2, distance: 2000, travelers: 3) // $750

let formatter = NumberFormatter()
formatter.numberStyle = .currency
//formatter.string(from: NSNumber(airfare))
