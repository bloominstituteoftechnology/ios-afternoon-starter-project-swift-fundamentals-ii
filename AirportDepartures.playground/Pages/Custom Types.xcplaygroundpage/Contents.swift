import UIKit


//: ## 1. Create custom types to represent an Airport Departures display
//: ![Airport Departures](matthew-smith-5934-unsplash.jpg)
//: Checkout data from [Departures at JFK Airport in NYC](https://www.airport-jfk.com/departures.php) for reference.
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
    case en_route = "En Route"
    case scheduled = "Scheduled"
    case canceled = "Canceled"
    case delayed = "Delayed"
    case boarding = "Boarding"
    
    // additional cases if needed
}

struct Airport {
    let city: String
    let code: String
}

struct Flight {
    var destination: Airport
    var airline: String
    var flight: String
    var departureTime: Date?    // Use optional if canceled invalidates date
    var terminal: String? // Use optional if not set yet (too soon to know)
    var status: FlightStatus
}

// Can be just the departures array, open ended class

class DepartureBoard {
    var airport: Airport
    var departures: [Flight]
    
    init(city: String, code: String) {
        airport = Airport(city: city, code: code)
        departures = []
    }
    
    // Question 5:

    func alertPassengers() {
        for flight in departures {
            
            var timeString = "TBD"
            if let time = flight.departureTime {
                timeString = "\(time)"
            }
            var terminalString = "TBD"
            if let terminal = flight.terminal {
                terminalString = terminal
            }
            
            switch flight.status {
            case .canceled:
                print("We're sorry your flight to \(flight.destination.city) was canceled, here is a $500 voucher")
            case .scheduled:
                print("Your flight to \(flight.destination.city) is scheduled to depart at \(timeString) from terminal: \(terminalString)")
            case .boarding:
                print("Your flight is boarding, please head to terminal: \(terminalString) immediately. The doors are closing soon.")
            case .en_route:
                print("Enjoy your flight!")
            case .delayed:
                print("Your flight has been delayed, please see one of the flight staff to so they can assist you.")
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

let lax = Airport(city: "Los Angeles", code: "LAX")
let roc = Airport(city: "Rochester", code: "ROC")
let bos = Airport(city: "Boston", code: "BOS")


let flight1 = Flight(destination: lax, airline: "Delta Air Lines", flight: "KL 6966", departureTime: nil, terminal: "4", status: .canceled)
let flight2 = Flight(destination: roc, airline: "Jet Blue Airways", flight: "B6 586", departureTime: Date(), terminal: nil, status: .scheduled)
let flight3 = Flight(destination: bos, airline: "KLM", flight: "KL 6966", departureTime: Date(), terminal: "4", status: .scheduled)

let nycDepartureBoard = DepartureBoard(city: "New York", code: "JFK")

nycDepartureBoard.departures.append(flight1)
nycDepartureBoard.departures.append(flight2)
nycDepartureBoard.departures.append(flight3)

//: ## 3. Create a free-standing function that can print the flight information from the `DepartureBoard`
//: a. Use the function signature: `printDepartures(departureBoard:)`
//:
//: b. Use a `for in` loop to iterate over each departure
//:
//: c. Make your `FlightStatus` enum conform to `String` so you can print the `rawValue` String values from the `enum`. See the [enum documentation](https://docs.swift.org/swift-book/LanguageGuide/Enumerations.html).
//:
//: d. Print out the current DepartureBoard you created using the function

func printDepartures(departureBoard: DepartureBoard) {
    for flight in departureBoard.departures {
        print("Destination: \(flight.destination.city) Airline: \(flight.airline) Flight: \(flight.flight) Departure Time: \(flight.departureTime) Terminal: \(flight.terminal) Status: \(flight.status.rawValue)")
    }
}

printDepartures(departureBoard: nycDepartureBoard)

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
    for flight in departureBoard.departures {
        
        var departureString: String = ""
        if let departureTime = flight.departureTime {
            departureString = "\(departureTime)"
            
            // Stretch goal
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .none
            dateFormatter.timeStyle = .short
            departureString = "\(dateFormatter.string(from: departureTime))"
            
        }
        
        var terminalString: String = ""
        if let terminal = flight.terminal {
            terminalString = terminal
        }
        
        print("Destination: \(flight.destination.city) Airline: \(flight.airline) Flight: \(flight.flight) Departure Time: \(departureString) Terminal: \(terminalString) Status: \(flight.status.rawValue)")
    }
}

// Call the function

printDepartures2(departureBoard: nycDepartureBoard)


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

nycDepartureBoard.alertPassengers()



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


    
func calculateAirfare(checkedBags: Int, distance: Int, travelers: Int) -> Double {
    let total = (Double(checkedBags) * 25 + Double(distance) * 0.1) * Double(travelers)
    return total
}

print(calculateAirfare(checkedBags: 2, distance: 2000, travelers: 3))



