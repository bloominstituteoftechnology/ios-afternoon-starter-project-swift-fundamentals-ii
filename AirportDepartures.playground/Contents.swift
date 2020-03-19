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
    case unknown = "Unknown"
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
    let flightNumber: String
    let terminal: String?
    let destination: String
    let flightDuration: Int
    let flightStatus: String
    let numberOfPassengers: Int?
    let timeOfDeparture: Date?
    let origin: String
}

class DepartureBoard {
    var flights: [Flight]
    var currentAirport: Airport
    
    init(flights: [Flight]) {
        self.flights = []
        self.currentAirport = Airport(name: "", location: "")
    }
    
    func addFlight(flight: Flight) {
        flights.append(flight)
    }
    
    func alertPassengers(flights: [Flight]) {
        for flight in flights {
            switch flight.flightStatus {
            case FlightStatus.canceled.rawValue:
                print("We're sorry your flight to \(flight.destination), was canceled, here is a $500 voucher.\n")
            case FlightStatus.scheduled.rawValue:
                print("Your flight to \(flight.destination) is scheduled to depart at \(flight.timeOfDeparture ?? Date()) from terminal: \(flight.terminal ?? "Please ask an employee for more info.")\n")
            case FlightStatus.enRoute.rawValue:
                print("Your flight #\(flight.flightNumber) is currently en route to its destination of \(flight.destination) with an estimated flight time of \(flight.flightDuration / 60) hours.\n")
            case FlightStatus.delayed.rawValue:
                print("Your flight to \(flight.destination) is experiencing some issues and has been issued a slight delay.\n")
            case FlightStatus.unknown.rawValue:
                print("Your flight to \(flight.destination) is experiencing some very odd issues. The status is currently unknown. This is a feature, not a bug. Do not panic.\n")
            default:
                print("Error: Invalid Flight State\n")
            }
        }
    }
    
    func timeSetter(date: Date) -> String {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "MMM d, h:mm a"
        let current = dateFormat.string(from: Date())
        return current
    }
}

var mainBoard = DepartureBoard(flights: [])

var airportA = Airport(name: "Lumbridge Flights", location: "Lumbridge, GL")

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
var flightA = Flight(flightNumber: "AA23",
                     terminal: "D2",
                     destination: "Los Angeles, CA",
                     flightDuration: 200,
                     flightStatus: FlightStatus.unknown.rawValue,
                     numberOfPassengers: 98,
                     timeOfDeparture: Date(),
                     origin: airportA.location)

var flightB = Flight(flightNumber: "CJ13",
                     terminal: nil,
                     destination: "Topeka, KS",
                     flightDuration: 280,
                     flightStatus: FlightStatus.scheduled.rawValue,
                     numberOfPassengers: 47,
                     timeOfDeparture: Date(),
                     origin: airportA.location)

var flightC = Flight(flightNumber: "ZG97",
                     terminal: "C7",
                     destination: "Varrock, RS",
                     flightDuration: 70,
                     flightStatus: FlightStatus.canceled.rawValue,
                     numberOfPassengers: 71,
                     timeOfDeparture: nil,
                     origin: airportA.location)

mainBoard.currentAirport = airportA

mainBoard.addFlight(flight: flightA)
mainBoard.addFlight(flight: flightB)
mainBoard.addFlight(flight: flightC)

//: ## 3. Create a free-standing function that can print the flight information from the `DepartureBoard`
//: a. Use the function signature: `printDepartures(departureBoard:)`
//:
//: b. Use a `for in` loop to iterate over each departure
//:
//: c. Make your `FlightStatus` enum conform to `String` so you can print the `rawValue` String values from the `enum`. See the [enum documentation](https://docs.swift.org/swift-book/LanguageGuide/Enumerations.html).
//:
//: d. Print out the current DepartureBoard you created using the function
func printDepartures(flights: [Flight]) {
    print("\(airportA.name)' Departures & Arrivals:")
    for flight in flights {
        print("\n+ Flight #: \(flight.flightNumber)")
        if flight.timeOfDeparture == nil {
            print("- Flight Status: \(FlightStatus.canceled.rawValue)")
        } else {
            print("- Flight Status: \(flight.flightStatus)")
        }
        print("- Terminal: \(flight.terminal ?? "TBD")")
        print("- Destination: \(flight.destination)")
        print("- Origin: \(flight.origin)")
        if flight.timeOfDeparture == nil {
           print("- Time of Departure: TBD")
        } else {
            print("- Time of Departure: \(flight.timeOfDeparture!)")
        }
        print("- Flight Time: \(flight.flightDuration)")
        if flight.numberOfPassengers == nil {
           print("- Occupancy: None (Parcel Only)")
        } else {
            print("- Time of Departure: \(flight.numberOfPassengers!)")
        }
    }
    print("") //New Line to seperate printed code
}

printDepartures(flights: mainBoard.flights)

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
//Updated previous function

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
mainBoard.alertPassengers(flights: mainBoard.flights)

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
func calcAirfare(checkedBags: Int, distance: Int, travelers: Int) -> Double {
    let bagCost = 25.0
    let costPerMile = 0.10
    let ticketCost = (Double(distance) * costPerMile) + (bagCost * Double(checkedBags))
    let airFare: Double = ticketCost * Double(travelers)
    return airFare
}

let airFare = calcAirfare(checkedBags: 2, distance: 2000, travelers: 3)
print("Air Fare: $\(airFare).")
