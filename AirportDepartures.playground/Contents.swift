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
    case EnRoute
    case Scheduled
    case Canceled
    case Delayed
    case Arrived
    case Boarding
}
let canceledFlightStatus = FlightStatus.Canceled

struct Airport {
    var name: String
    let airportCode: String
    
//    func boardString () -> String {
//        return name + " (" + airportCode + ")"
//    }
}

struct Flight {
    let flightNumber: String
    var destination: Airport
    var departureTime: Date?
    let terminal: String?
    let airline: String
    var status: FlightStatus
    
//    init (flightNumber: String, destination: Airport, departureTime: Date?, terminal: String?, airline: String, status: FlightStatus) {
//        self.flightNumber = flightNumber
//        self.destination = Airport(name: airportName, code: airportCode)
//        self.departureTime = departureTime
//        self.terminal = terminal
//        self.airline = airline
//        self.status = status
//            ECT...
// }

    func departureString() -> String {             // function to prevent app crashing due to no time value or 'nil' value. Creates String "TBD" in it's place. Question 4
        guard let time = self.departureTime else {
            return "TBD"
        }
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: time)
    }
}

class DepartureBoard {
    var flights: [Flight] = []
    
    init () {
           
        self.addNewFlight(addNewFlight: Flight(flightNumber: "AA101", destination: Airport(name: "Seoul", airportCode: "ICN"), departureTime: Date(), terminal: "1", airline: "American Airlines", status: .Scheduled))
        self.addNewFlight(addNewFlight: Flight(flightNumber: "AA102", destination: Airport(name: "Amsterdam", airportCode: "AMS"), departureTime: nil, terminal: nil, airline: "American Airlines", status: .Canceled))
        self.addNewFlight(addNewFlight: Flight(flightNumber: "AA103", destination: Airport(name: "Los Angeles", airportCode: "LAX"), departureTime: Date(), terminal: "55", airline: "American Airlines", status: .Arrived))
    }

    func addNewFlight(addNewFlight: Flight) {
        flights.append(addNewFlight)
    }

    func flightStatusAlert() {
        var terminalString = "TBD"
        var departureTimeString = "TBD"
        for thisFlight in flights {
            if let terminal = thisFlight.terminal {
                    terminalString = terminal
            }
            if let departureTime = thisFlight.departureTime {
                               departureTimeString = "\(departureTime)"
            }
            
            
            switch thisFlight.status {
            case .EnRoute:
                print("Your flight is \(thisFlight.status.rawValue).")
            case .Scheduled:
                print("Your flight to \(thisFlight.destination) is scheduled to depart at \(departureTimeString) from terminal: \(terminalString).")
            case .Canceled:
                print("We're sorry your flight to \(thisFlight.destination) was canceled, here is a $500 voucher")
                //: e. If you have any other cases to handle please print out appropriate messages
                //:
                //: d. Call the `alertPassengers()` function on your `DepartureBoard` object below
                //:
                //: f. Stretch: Display a custom message if the `terminal` is `nil`, tell the traveler to see the nearest information desk for more details.

            case .Delayed:
                print("Your flight is \(thisFlight.status.rawValue).")
            case .Arrived:
                print("Your flight has \(thisFlight.status.rawValue).")
            case .Boarding:
                print("Your flight is boarding, please head to terminal: \(terminalString) immediately. The doors are closing soon.")
            }
        }
    }
}
    
var departureBoard = DepartureBoard()
 

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
//var flight1 = Flight.init(flightNumber: "AA101", destination: Airport(name: "Seoul", airportCode: "ICN"), departureTime: Date(), terminal: "1", airline: "American Airlines", status: .Scheduled))
//var flight2 = Flight.init(flightNumber: "AA102", destination: Airport(name: "Amsterdam", airportCode: "AMS"), departureTime: nil, terminal: nil, airline: "American Airlines", status: .Canceled))
//var flight2 = Flight.init(flightNumber: "AA103", destination: Airport(name: "Los Angeles", airportCode: "LAX"), departureTime: Date(), terminal: "55", airline: "American Airlines", status: .Arrived))
//
//print(flight1)
//print(flight2)
//print(flight3)
//
//departureBoard.flight.append(flight1)
//departureBoard.flights.append(flight2)
//departureBoard.flights.append(flight3)
//: ## 3. Create a free-standing function that can print the flight information from the `DepartureBoard`
//: a. Use the function signature: `printDepartures(departureBoard:)`
//:
//: b. Use a `for in` loop to iterate over each departure
//:
//: c. Make your `FlightStatus` enum conform to `String` so you can print the `rawValue` String values from the `enum`. See the [enum documentation](https://docs.swift.org/swift-book/LanguageGuide/Enumerations.html).
//:
//: d. Print out the current DepartureBoard you created using the function
func printDepartures(departureBoard: DepartureBoard) {

    for thisFlight in departureBoard.flights {
        
        let gate = thisFlight.terminal ?? "TBD"
        
        
        print("Airline: \(thisFlight.airline) Flight: \(thisFlight.flightNumber) Destination: \(thisFlight.destination.name) Terminal: \(String(describing: gate))  Status: \(thisFlight.status)")
        
    }
}
//printDepartures(departureBoard: departureBoard)
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

    for thisFlight in departureBoard.flights {
        
        let gate = thisFlight.terminal ?? " "
        let time = thisFlight.departureString()
        
        print("Airline: \(thisFlight.airline) Flight: \(thisFlight.flightNumber) Destination: \(thisFlight.destination.name) Terminal: \(String(describing: gate)) Departure Time: \(String(describing: time)) Status: \(thisFlight.status)")
        
    }
}
printDepartures(departureBoard: departureBoard)



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
departureBoard.flightStatusAlert()



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
    var bag: Int = 25
    var eachMile: Double = 0.10
    var totalBags: Int = (checkedBags * travelers)
    
    var ticketCost = (Double(travelers) * (Double(distance) * eachMile)) + (Double(totalBags * bag))
    

    return ticketCost

}
print(calculateAirfare(checkedBags: 2, distance: 2000, travelers: 3))
