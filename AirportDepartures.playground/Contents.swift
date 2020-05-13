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
    case EnRoute = "En Route"
    case Scheduled = "Scheduled"
    case Canceled = "Canceled"
    case Delayed = "Delayed"
    case Boarding = "Boarding"
}

struct Airport {
    let name: String
}

struct Flight {
    var status: FlightStatus
    var terminal: String? //Terminal "waiting to arrive on time" or #
    var time: Date?
    var destination: String
    var airline: String
    var flightID: String
    
}

class DepartureBoard {
    let currentAirport: Airport
    var departureFlights: [Flight]
    
    init(currentAirport: Airport) {
        self.currentAirport = currentAirport
        self.departureFlights = []
    }
    
    func upcomingFlightAlert(flight: Flight) {
        switch flight.status {
            case .Boarding:
                if let flightTerminal = flight.terminal {
                    print("Your flight is boarding, please head to terminal: \(flightTerminal) immediately. The doors are closing soon.")
                } else {
                    print("See the nearest information desk for more details.")
                }
            case .Canceled:
                print("We're sorry your flight to (city) was canceled, here is a $500 voucher")
            case .Delayed:
                print("We're sorry, your flight is delayed.")
            case .EnRoute:
                print("Your flight is en route.")
            case .Scheduled:
                if let flightTime = flight.time {
                    if let flightTerminal = flight.terminal {
                        print("Your flight to \(flight.destination) is scheduled to depart at \(flightTime) from terminal: \(flightTerminal)")
                    } else {
                        print("See the nearest information desk for more details.")
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
//create the airport and the departure board
let NYC_airport = Airport(name: "JFK Airport in NYC")
var NYC_departureBoard = DepartureBoard(currentAirport: NYC_airport)

//create the flights
let orlandoFlight = Flight(status: .Scheduled, terminal: "7",
                           time: Date(), destination: "Orlando", airline: "Delta Air Lines", flightID: "KL 6966")
let atlantaFlight = Flight(status: .Canceled, terminal: nil, time: nil, destination: "Atlanta",
                           airline: "Jet Blue Airways", flightID: "B6 586")
let dallasFlight = Flight(status: .EnRoute, terminal: "4",
                          time: Date(), destination: "Dallas", airline: "KLM", flightID: "KL 6966")

//add the flights to the departure board
NYC_departureBoard.departureFlights.append(atlantaFlight)
NYC_departureBoard.departureFlights.append(orlandoFlight)
NYC_departureBoard.departureFlights.append(dallasFlight)
//: ## 3. Create a free-standing function that can print the flight information from the `DepartureBoard`
//: a. Use the function signature: `printDepartures(departureBoard:)`
//:
//: b. Use a `for in` loop to iterate over each departure
//:
//: c. Make your `FlightStatus` enum conform to `String` so you can print the `rawValue` String values from the `enum`. See the [enum documentation](https://docs.swift.org/swift-book/LanguageGuide/Enumerations.html).
//:
//: d. Print out the current DepartureBoard you created using the function
func printDepartures(departureBoard: DepartureBoard) {
    for flight in departureBoard.departureFlights {
        print("The Flight is \(flight.status.rawValue)")
    }
}

printDepartures(departureBoard: NYC_departureBoard)

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
    for flight in departureBoard.departureFlights {
        let flightTerminal = flight.terminal ?? ""
        if let departureTime = flight.time {
        print("Destination: \(flight.destination) Airline: \(flight.airline) Flight: \(flight.flightID) Departure Time:  \(departureTime) Terminal: \(flightTerminal) Status: \(flight.status.rawValue)")
        } else {
           print("Destination: \(flight.destination) Airline: \(flight.airline) Flight: \(flight.flightID) Departure Time:   Terminal: \(flightTerminal) Status: \(flight.status.rawValue)")
        }
    }
}

printDepartures2(departureBoard: NYC_departureBoard)
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
for flight in NYC_departureBoard.departureFlights {
    NYC_departureBoard.upcomingFlightAlert(flight: flight)
}



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
    let bagCost: Double = 25.00
    let costPerMile: Double = 0.10
    let totalBagCost = Double(checkedBags) * bagCost
    let totalMileCost = Double(distance) * costPerMile
    let airfareTotal: Double = (totalBagCost + totalMileCost) * Double(travelers)
    return airfareTotal
}

func convertDoubleToCurrency(amount: Double) -> String {
    let numberFormatter = NumberFormatter()
    numberFormatter.numberStyle = .currency
    numberFormatter.locale = Locale.current
    return numberFormatter.string(from: NSNumber(value: amount)) ?? ""
}

print(convertDoubleToCurrency(amount: calculateAirfare(checkedBags: 2, distance: 2000, travelers: 3)))


