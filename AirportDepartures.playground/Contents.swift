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
    case boarding = "Boarding"
}

struct Airport {
    let name: String
    let departure: Bool
    let arrival: Bool
}

struct Flight {
    var flightNumber: String
    var departureTime: Date?
    var terminal: String?
    var flightStatus: FlightStatus
    var destination: String
    var airline: String
    
    init(departureTime: Date?, destination: String, terminal: String? = nil, flightStatus: FlightStatus = .scheduled, flightNumber: String, airline: String) {
        self.departureTime = departureTime
        self.terminal = terminal
        self.flightStatus = flightStatus
        self.destination = destination
        self.flightNumber = flightNumber
        self.airline = airline
    }
}

class DepartureBoard {
    var departureFlights: [Flight]
    var currentAirport: Airport
    
    init(currentAirport: Airport, departureFlights: [Flight] = []) {
        self.currentAirport = currentAirport
        self.departureFlights = departureFlights
    }
    
    func alertPassengers() {
        for flight in departureFlights {
            if let terminal = flight.terminal {
                switch flight.flightStatus {
                case .canceled:
                    print("We're sorry your flight to \(flight.destination) was canceled, here is a $500 voucher")
                case .scheduled:
                    if let departureTime = flight.departureTime {
                        print("Your flight to \(flight.destination) is scheduled to depart at \(departureTime) from terminal: \(terminal)")
                    } else {
                        print("Your flight to \(flight.destination) is scheduled for a TBD time. To find out more vitist the nearest information desk.")
                    }
                case .boarding:
                    print("Your flight is boarding, please head to terminal: \(terminal) immediately. The doors are closing soon.")
                case .enRoute:
                    print("Your flight is En Route to \(flight.destination).")
                case .delayed:
                    print("Your flight had been delayed. For more details about your flight please see the nearest information desk.")
                }
            } else {
                print("Your flight hasn't been assigned a terminal. For more details please see the nearest information desk.")
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
var flightToXining = Flight(departureTime: nil, destination: "Xining", terminal: "6B", flightStatus: .canceled, flightNumber: "MU 67834", airline: "China Eastern")
var morningFlight = Flight(departureTime: Date(), destination: "Somewhere", terminal: nil, flightStatus: .scheduled, flightNumber: "LE 89637", airline: "Special Air")
var afternoonFlightToNewYork = Flight(departureTime: Date(), destination: "New York", terminal: "14D", flightStatus: .scheduled, flightNumber: "AA 83583", airline: "Alaska Airlines")

var seattleAirport = Airport(name: "Seattle Airport", departure: true, arrival: false)

var seattleAirportDepartureBoard = DepartureBoard(currentAirport: seattleAirport)

// New Flights
seattleAirportDepartureBoard.departureFlights.append(flightToXining)
seattleAirportDepartureBoard.departureFlights.append(morningFlight)
seattleAirportDepartureBoard.departureFlights.append(afternoonFlightToNewYork)
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
        
        var flightInformationString = "Destination: "
        flightInformationString += flight.destination
        
        flightInformationString += " Airline: "
        flightInformationString += flight.airline
        
        flightInformationString += " Flight: "
        flightInformationString += flight.flightNumber
        
        flightInformationString += " Departure Time: "
        if let flightTime = flight.departureTime {
            flightInformationString += "\(flightTime)"
        }
        
        flightInformationString += " Terminal: "
        if flight.terminal != nil {
            flightInformationString += flight.terminal!
        }
        
        flightInformationString += " Status: "
        flightInformationString += flight.flightStatus.rawValue
        
        print(flightInformationString)
    }
}

printDepartures(departureBoard: seattleAirportDepartureBoard)
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
// Adjusted the above function
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
seattleAirportDepartureBoard.alertPassengers()
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
    var totalPrice: Double = 0
    
    totalPrice += Double(distance) * 0.10
    totalPrice += Double(checkedBags) * 25
    totalPrice *= Double(travelers)
    
    return totalPrice
}

print("A 2000 mile flight with two bags for three travelers costs a total of $\(calculateAirfare(checkedBags: 2, distance: 2000, travelers: 3))")
print("A 3000 mile flight with four bags for six travelers costs a total of $\(calculateAirfare(checkedBags: 4, distance: 3000, travelers: 6))")
print("A 8000 mile flight with eight bags for two travelers costs a total of $\(calculateAirfare(checkedBags: 8, distance: 8000, travelers: 2))")
