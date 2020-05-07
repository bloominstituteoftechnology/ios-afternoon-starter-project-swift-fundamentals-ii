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
    case enroute = "En Route"
    case scheduled = "On Schedule"
    case canceled = "Canceled"
    case delayed = "Delayed"
    case boarding = "Boarding"
}

struct Airport {
    let name: String
    let code: String
    let city: String
    let state: String
    let country: String
}

struct Flight {
    let destination: String
    let airlineName: String
    let flightCode: String
    let departureTime: Date?
    let terminal: String?
    let status: FlightStatus
}

class DepartureBoard {
    var flights: [Flight]
    
    init(flights: [Flight]) {
        self.flights = flights
    }
   
    func alertPassengers() {
        for eachFlight in departureBoard.flights {
            switch eachFlight.status {
                case .canceled:
                    print("We're sorry your flight to \(eachFlight.destination) was canceled, here is a $500 voucher");
                case .scheduled:
                    print("Your flight to \(eachFlight.destination) is scheduled to depart at \(eachFlight.departureTime?.description ?? "TBD")) from terminal: \(String(describing: eachFlight.terminal ?? "TBD"))");
                case .boarding:
                    print("Your flight is boarding, please head to terminal: \(String(describing: eachFlight.departureTime)) immediately. The doors are closing soon.");
                case .delayed:
                    print("Your flight has been delayed.");
                default:
                    print("Your flight will arrive soon.")
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
let jfkAirport = Airport(name: "John F. Kenney Airport",
                         code: "JFK",
                         city: "New York City",
                         state: "New York",
                         country: "USA")
var flight1 = Flight(destination: jfkAirport.code, airlineName: "Southwest", flightCode: "SW344",                     departureTime: Date(), terminal: "4", status: .scheduled)
var flight2 = Flight(destination: jfkAirport.code, airlineName: "Alaska", flightCode: "AK9739",                       departureTime: nil, terminal: "8", status: .canceled)
var flight3 = Flight(destination: jfkAirport.code, airlineName: "Delta", flightCode: "DL889",                         departureTime: Date(), terminal: nil, status: .delayed)



var threeNewFlights = [Flight]()
threeNewFlights.append(flight1)
threeNewFlights.append(flight2)
threeNewFlights.append(flight3)

let departureBoard = DepartureBoard(flights: threeNewFlights)

//: ## 3. Create a free-standing function that can print the flight information from the `DepartureBoard`
//: a. Use the function signature: `printDepartures(departureBoard:)`
//:
//: b. Use a `for in` loop to iterate over each departure
//:
//: c. Make your `FlightStatus` enum conform to `String` so you can print the `rawValue` String values from the `enum`. See the [enum documentation](https://docs.swift.org/swift-book/LanguageGuide/Enumerations.html).
//:
//: d. Print out the current DepartureBoard you created using the function



func printDepartures(departureBoard: DepartureBoard) {
    for eachFlight in departureBoard.flights {
        if let unwrappedDepartureTime = eachFlight.departureTime, let unwrappedTerminal = eachFlight.terminal {
            print("Destination: \(eachFlight.destination) Airline: \(eachFlight.airlineName) Flight Number: \(eachFlight.flightCode) Departure Time: \(unwrappedDepartureTime) Terminal: \(unwrappedTerminal) Status: \(eachFlight.status.rawValue)")
        } else {
            if let unwrappedDepartureTime = eachFlight.departureTime {
                print("Destination: \(eachFlight.destination) Airline: \(eachFlight.airlineName) Flight Number: \(eachFlight.flightCode) Departure Time: \(unwrappedDepartureTime) Terminal: \(eachFlight.terminal ?? "") Status: \(eachFlight.status.rawValue)")
            } else {
                if let unwrappedTerminal = eachFlight.terminal {
                    print("Destination: \(eachFlight.destination) Airline: \(eachFlight.airlineName) Flight Number: \(eachFlight.flightCode) Departure Time: \("") \(unwrappedTerminal) Status:  \(eachFlight.status.rawValue)")
                }
            }
        }
    }
}
    
printDepartures(departureBoard: departureBoard)

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
    for eachFlight in departureBoard.flights {
        if let unwrappedDepartureTime = eachFlight.departureTime, let unwrappedTerminal = eachFlight.terminal {
            print("Destination: \(eachFlight.destination) Airline: \(eachFlight.airlineName) Flight Number: \(eachFlight.flightCode) Departure Time: \(unwrappedDepartureTime) Terminal: \(unwrappedTerminal) Status: \(eachFlight.status.rawValue)")
        } else {
            if let unwrappedDepartureTime = eachFlight.departureTime {
                print("Destination: \(eachFlight.destination) Airline: \(eachFlight.airlineName) Flight Number: \(eachFlight.flightCode) Departure Time: \(unwrappedDepartureTime) Terminal: \(eachFlight.terminal ?? "") Status: \(eachFlight.status.rawValue)")
            } else {
                if let unwrappedTerminal = eachFlight.terminal {
                    print("Destination: \(eachFlight.destination) Airline: \(eachFlight.airlineName) Flight Number: \(eachFlight.flightCode) Departure Time: \("") \(unwrappedTerminal) Status:  \(eachFlight.status.rawValue)")
                }
            }
        }
    }
}

printDepartures2(departureBoard: departureBoard)



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
departureBoard.alertPassengers()



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
    let checkedBagTotal = checkedBags*25
    let distanceTotal = distance/10
    let travelersTotal = travelers*500
    let total: Double = Double(checkedBagTotal + distanceTotal + travelersTotal)
    return(total)
}

print(calculateAirfare(checkedBags: 4, distance: 1000, travelers: 2))
print(calculateAirfare(checkedBags: 8, distance: 100, travelers: 8))
print(calculateAirfare(checkedBags: 3, distance: 5320, travelers: 3))

