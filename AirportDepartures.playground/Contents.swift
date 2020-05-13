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
case boarding = "Boarding"
case delayed = "Delayed"
case landed = "Landed"
}

struct AirportDestination {
var location: String
}

struct Flight {
var destination: AirportDestination
var departureTime: Date?
var flightNumber: String
var terminal: String?
var airline: String
var status: FlightStatus.RawValue
}


class DepartureBoard {
var currentFlights: [Flight]
var currentAirport: String

init (currentFlights: [Flight], currentAirport: String) {
    self.currentFlights = currentFlights
    self.currentAirport = currentAirport
}
func addFlights() {
     currentFlights.append(contentsOf: flights)
 }
    
func statusAlert() {
    for flight in currentFlights
      {
            switch flight.status {
        case "Canceled":
            print("We're sorry your flight to \(flight.destination.location) was canceled, here is a $500 voucher")
        case "Scheduled":
            var alert: String = "Your flight to \(flight.destination.location) is scheduled to"
            if let unwrappedDepartureTime = flight.departureTime {
                alert += " depart at \(unwrappedDepartureTime)"
            } else {
                alert += " depart at TBD"
            }
            if let unwrappedTerminal = flight.terminal {
                alert += " from terminal \(unwrappedTerminal)"
            } else {
                alert += " from terminal TBD"
                }
                print(alert)
        case "Boarding":
            if let unwrappedTerminal = flight.terminal {
                print("Your flight is boarding, please head to terminal: \(unwrappedTerminal) immediately. The doors are closing soon.")
            }
        case "En Route":
            print("Your flight is currently En Route.")
        case "Delayed":
            print("Your flight has been delayed.")
        case "Landed":
            print("Your flight has landed.")
        default:
            break
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
let board = DepartureBoard(currentFlights: [], currentAirport: "JFK Airport")


let spainFlight = Flight(destination: AirportDestination(location: "Port of Spain"), departureTime: Date(), flightNumber: "BW551", terminal: "4", airline: "Carribean Airlines", status: "Scheduled")

let tokyoFlight = Flight(destination: AirportDestination(location: "Tokyo, Japan"), departureTime: Date(), flightNumber: "JL3", terminal: "1", airline: "JAL", status: "Canceled")

let koreaFlight = Flight(destination: AirportDestination(location: "Seoul, Korea"), departureTime: Date(), flightNumber: "KE250", terminal: nil, airline: "Korean Air", status: "En Route")

let flights = [spainFlight, tokyoFlight, koreaFlight]

board.addFlights()

//: ## 3. Create a free-standing function that can print the flight information from the `DepartureBoard`
//: a. Use the function signature: `printDepartures(departureBoard:)`
//:
//: b. Use a `for in` loop to iterate over each departure
//:
//: c. Make your `FlightStatus` enum conform to `String` so you can print the `rawValue` String values from the `enum`. See the [enum documentation](https://docs.swift.org/swift-book/LanguageGuide/Enumerations.html).
//:
//: d. Print out the current DepartureBoard you created using the function
func printDepartures(departureBoard: DepartureBoard) {
for flight in flights {
    print(flight)
}
}

printDepartures(departureBoard: board)


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
//func statusAlert(departureBoard: DepartureBoard) {
//    for flight in flights {
//        switch flight.status {
//        case "Canceled":
//            print("We're sorry your flight to (city) was canceled, here is a $500 voucher")
//        case "Scheduled":
//            print("Your flight to (city) is scheduled to depart at (time) from terminal: (terminal)")
//        case "Boarding":
//            print("Your flight is boarding, please head to terminal: (terminal) immediately. The doors are closing soon.")
//        case "En Route":
//            print("Your flight is currently En Route.")
//        case "Delayed":
//            print("Your flight has been delayed.")
//        case "Landed":
//            print("Your flight has landed.")
//        default:
//            break
//        }
//    }
//}

board.statusAlert()

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
func calculateAirfare(checkedBags: Int, distance: Double, travelers: Int) -> Double {
    let ticketPrice = Double(distance) * 0.10
    let bagPrice = checkedBags * 25
    let totalCost: Double = (ticketPrice * Double(travelers)) + Double(bagPrice)
    return totalCost
}

calculateAirfare(checkedBags: 3, distance: 1000.0, travelers: 3)
calculateAirfare(checkedBags: 6, distance: 2534.23, travelers: 6)
calculateAirfare(checkedBags: 2, distance: 3000.45, travelers: 2)
