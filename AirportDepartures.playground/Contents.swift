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
    case canceled = "CANCELED"
    case delayed = "Delayed"
}
struct Airport {
    let name: String
}
struct Flight {
    let date: String?
    let terminal: String?
    let flightStatus: FlightStatus
    let destination: String
    let name: String
    let destinationDate: String?
}
class DepartureBoard {
    var flights: [Flight] = []
    let currentAirport: Airport
    init(flights: [Flight], currentAirport: Airport){
        self.flights = flights
        self.currentAirport = currentAirport
    }
    func alertPassengers() {
        for flight in flights {
            switch flight.flightStatus {
            case FlightStatus.canceled:
                print("We're sorry your flight to \(flight.destination) was canceled! Here's a $500 dollar voucher for your inconvenience!")
            case FlightStatus.enRoute:
                if let unwrappedDate = flight.date {
                print("I'm sorry, but your flight to \(flight.destination) left on \(unwrappedDate)")
                }
            case FlightStatus.scheduled:
                if let unwrappedDate = flight.date, let unwrappedTerminal = flight.terminal {
                print("Your flight to \(flight.destination) is scheduled for \(unwrappedDate). Please head to terminal \(unwrappedTerminal).")
                }
            default:
                print("Hi this is your app developer. Something went wrong somewhere.")
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
let flight93 = Flight(date: "12/25/20", terminal: "V" , flightStatus: FlightStatus.scheduled, destination: "Svalbard, Norway", name: "Flight 93", destinationDate: "12/26/20" )
let flight111 = Flight(date: "12/24/20", terminal: nil, flightStatus: FlightStatus.enRoute, destination: "Rochester, New York", name: "Flight 111", destinationDate: "12/25/20")
let flight13 = Flight(date: nil, terminal: nil, flightStatus: FlightStatus.canceled, destination: "Seattle, Washington", name: "Flight 13", destinationDate: nil)
var flights: [Flight] = []
flights.append(flight93)
flights.append(flight13)
flights.append(flight111)
let airlineCompanyA = DepartureBoard(flights: flights, currentAirport: Airport.init(name: "JFK"))
//: ## 3. Create a free-standing function that can print the flight information from the `DepartureBoard`
//: a. Use the function signature: `printDepartures(departureBoard:)`
//:
//: b. Use a `for in` loop to iterate over each departure
//:
//: c. Make your `FlightStatus` enum conform to `String` so you can print the `rawValue` String values from the `enum`. See the [enum documentation](https://docs.swift.org/swift-book/LanguageGuide/Enumerations.html).
//:
//: d. Print out the current DepartureBoard you created using the function
func printDepartures() {
    for flight in flights {
        print(flight.flightStatus.rawValue)
    }
}
printDepartures()

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
func printDepartures2() {
    for flight in flights {
        if let unwrappedTerminal = flight.terminal, let unwrappedDate = flight.date, let unwrappedDestinationDate = flight.destinationDate {
            print("Destination: \(flight.destination)  Flight: \(flight.name) Departure Date: \(unwrappedDate) Terminal: \(unwrappedTerminal) Status: \(flight.flightStatus.rawValue) Destination Date: \(unwrappedDestinationDate)")
        } else if flight.flightStatus == FlightStatus.enRoute, let unwrappedDate = flight.date, let unwrappedDestinationDate = flight.destinationDate {
            print("Destination: \(flight.destination) Flight: \(flight.name) Departure Date: \(unwrappedDate) Terminal: Sorry, Already Gone Status: \(flight.flightStatus.rawValue) Destination Date: \(unwrappedDestinationDate)")
        } else {
            print("Destination: \(flight.destination) Flight: \(flight.name) Departure Date: TBD Terminal: TBD Status: \(flight.flightStatus.rawValue) Destination Date: TBD")
        }
    }
}
printDepartures2()

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
airlineCompanyA.alertPassengers()



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
func calculateAirfare(carryOns: Double, distance: Double, travelers: Double) -> Double {
    let carryOnTotal = carryOns * 25
    let distancePrice = distance * 0.1
    let ticketCost = carryOnTotal + distancePrice
    let totalTicketCost = ticketCost * travelers
    print(totalTicketCost)
    return totalTicketCost
}
calculateAirfare(carryOns: 13, distance: 500, travelers: 4.5)
calculateAirfare(carryOns: 2, distance: 2000, travelers: 3)
calculateAirfare(carryOns: 5, distance: 4997, travelers: 37)

