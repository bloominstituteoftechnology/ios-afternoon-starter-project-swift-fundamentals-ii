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
    case scheduled
    case canceled
    case delayed
    case landed
    case boarding
}

struct Airport {
    let name: String
}

struct Flight {
    let number: String
    let airline: String
    let destination: Airport
    let status: FlightStatus
    let departureTime: Date?
    let terminal: String?
}

let dateFormatter = DateFormatter()
dateFormatter.dateStyle = .none
dateFormatter.timeStyle = .short

class DepartureBoard {
    var currentAirport: Airport
    var flights: [Flight]
    
    init(currentAirport: Airport, flights: [Flight]) {
        self.currentAirport = currentAirport
        self.flights = flights
    }
    
//    a. If the flight is canceled print out: "We're sorry your flight to (city) was canceled, here is a $500 voucher"
//
//    b. If the flight is scheduled print out: "Your flight to (city) is scheduled to depart at (time) from terminal: (terminal)"
//
//    c. If their flight is boarding print out: "Your flight is boarding, please head to terminal: (terminal) immediately. The doors are closing soon."
//
//    d. If the departureTime or terminal are optional, use "TBD" instead of a blank String
//
//    e. If you have any other cases to handle please print out appropriate messages
//
//    d. Call the alertPassengers() function on your DepartureBoard object below
//
//    f. Stretch: Display a custom message if the terminal is nil, tell the traveler to see the nearest information desk for more details.
    
    func alertPassengers() {
        for flight in flights{
            let depTime: String
            let terminalNum: String
            
            if let departureTime = flight.departureTime {
                depTime = String(describing: dateFormatter.string(from: departureTime))
            } else {
                depTime = "TBD"
            }
            if let terminal = flight.terminal {
                terminalNum = terminal
            } else {
                terminalNum = "TBD"
                print("Please see the nearest information desk for the terminal infomation.")
            }
                switch flight.status {
                case .canceled:
                    print("We're sorry your flight to \(flight.destination.name) was canceled, here is a $500 voucher")
                case .scheduled:
                    print("Your flight to \(flight.destination.name) is scheduled to depart at \(depTime) from terminal: \(terminalNum)")
                case .boarding:
                    print("Your flight is boarding, please head to terminal: \(terminalNum) immediately. The doors are closing soon.")
                case .delayed:
                    print("Your flight is delayed. Please check in with the airline.")
                case .landed:
                    print("Your flight is landed safely, have a nice trip.")
                default:
                    print("There is a error with your flight ticket. Please check in with the airline.")
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
let flight1 = Flight(number: "5C 1981", airline: "C.A.L. Cargo Airlines", destination: Airport(name: "Las Vegas"),
                     status: .landed, departureTime: Date(), terminal: "7")
let flight2 = Flight(number: "B6 2611", airline: "JetBlue Airways", destination: Airport(name: "Los Angeles"),
                     status: .canceled, departureTime: nil, terminal: "2")
let flight3 = Flight(number: "KR 7750", airline: "Korean Air", destination: Airport(name: "Incheon"),
                     status: .scheduled, departureTime: Date(), terminal: nil)
var flights: [Flight] = []
flights.append(flight1)
flights.append(flight2)
flights.append(flight3)
//print(flights)


//: ## 3. Create a free-standing function that can print the flight information from the `DepartureBoard`
//: a. Use the function signature: `printDepartures(departureBoard:)`
//:
//: b. Use a `for in` loop to iterate over each departure
//:
//: c. Make your `FlightStatus` enum conform to `String` so you can print the `rawValue` String values from the `enum`. See the [enum documentation](https://docs.swift.org/swift-book/LanguageGuide/Enumerations.html).
//:
//: d. Print out the current DepartureBoard you created using the function
func printDepartures(departureBoard: DepartureBoard) {
    
    print("Departures from \(departureBoard.currentAirport.name)\n")
    
    for flight in departureBoard.flights {
        if let departureTime = flight.departureTime{
            if let terminal = flight.terminal {
                print("Destination: \(flight.destination.name)\t Airline: \(flight.airline)\t Flight Number: \(flight.number)\t Departure Time: \(dateFormatter.string(from: departureTime))\t Terminal: \(terminal)\t Status: \(flight.status)")
            } else {
                print("Destination: \(flight.destination.name)\t Airline: \(flight.airline)\t Flight Number: \(flight.number)\t Departure Time: \(dateFormatter.string(from: departureTime))\t Terminal: \t\t Status: \(flight.status)")
            }
        } else if let terminal = flight.terminal {
            print("Destination: \(flight.destination.name)\t Airline: \(flight.airline)\t Flight Number: \(flight.number)\t Departure Time: \t\t Terminal: \(terminal)\t Status: \(flight.status)")
        } else {
            print("Destination: \(flight.destination.name)\t Airline: \(flight.airline)\t Flight Number: \(flight.number)\t Departure Time: \t\t Terminal: \t\t Status: \(flight.status)")
        }
    }
}

let departureBoard = DepartureBoard(currentAirport: Airport(name: "LAX"), flights: flights)
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
// step 3


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
    let bagCost = Double(checkedBags) * 25.0
    let mileCost = Double(distance) * 0.1
    let ticketCost = 150.0
    let travelerCost = ticketCost * Double(travelers)
    let totalCost = bagCost + mileCost + travelerCost
    
    return totalCost
}

let currencyStyle = NumberFormatter()
currencyStyle.numberStyle = .currency
currencyStyle.locale = Locale.current

print(currencyStyle.string(from: NSNumber(value: calculateAirfare(checkedBags: 2, distance: 5000, travelers: 1)))!)
print(currencyStyle.string(from: NSNumber(value: calculateAirfare(checkedBags: 0, distance: 100, travelers: 2)))!)
print(currencyStyle.string(from: NSNumber(value: calculateAirfare(checkedBags: 6, distance: 18000, travelers: 3)))!)
print(currencyStyle.string(from: NSNumber(value: calculateAirfare(checkedBags: 3, distance: 10000, travelers: 2)))!)

