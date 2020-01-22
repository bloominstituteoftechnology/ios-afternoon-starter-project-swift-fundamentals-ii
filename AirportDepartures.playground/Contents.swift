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
enum FlightStatus: String{
    case enroute = "enroute"
    case landed = "landed"
    case scheduled = "scheduled"
    case delayed = "delayed"
    case canceled = "canceled"
}

struct Airport {
    
    let city: String
    
}

struct Flight {
    let departureTime: Date?
    let terminal: String?
    let destination: Airport
    let flightStatus: FlightStatus
}

class DepartureBoard {
    var departureFlights: [Flight]
    var currentAirport: Airport
    
    init(city: String) {
        self.currentAirport = Airport(city: city)
        self.departureFlights = []
        
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


let LAX = Airport(city: "Los Angelos")
let CAE = Airport(city: "Columbia")
let BOS = Airport(city: "Boston")

let flight1 = Flight(departureTime: Date(), terminal: "Delta", destination: LAX, flightStatus: .enroute)
let flight2 = Flight(departureTime: Date(), terminal: "American", destination: CAE, flightStatus: .canceled)
let flight3 = Flight(departureTime: Date(), terminal: "Delta", destination: BOS, flightStatus: .landed)


let newDepartureBoard = DepartureBoard(city: "Hollywood")

newDepartureBoard.departureFlights.append(flight1)
newDepartureBoard.departureFlights.append(flight2)
newDepartureBoard.departureFlights.append(flight3)







//: ## 3. Create a free-standing function that can print the flight information from the `DepartureBoard`
//: a. Use the function signature: `printDepartures(departureBoard:)`
//:
//: b. Use a `for in` loop to iterate over each departure
//:
//: c. Make your `FlightStatus` enum conform to `String` so you can print the `rawValue` String values from the `enum`. See the [enum documentation](https://docs.swift.org/swift-book/LanguageGuide/Enumerations.html).
//:
//: d. Print out the current DepartureBoard you created using the function
func printDepartures(departureBoard: DepartureBoard) {
    for departureFlight in departureBoard.departureFlights {
        print(departureFlight)
    }
    
}
printDepartures(departureBoard: newDepartureBoard)






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
           
        print("Destination: \(flight.destination.city) Terminal: \(flight.terminal) Flight Status: \(flight.flightStatus) Departure Time: \(flight.departureTime)")
       }

}

print(newDepartureBoard.departureFlights)












    func alertPassengers() {
        for flight in departureFlights {
            
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
    let total = (Double(checkedBags) * 25 + Double(distance) * 0.1) * Double(travelers)
    return total
}

print(calculateAirfare(checkedBags: 2, distance: 2000, travelers: 3))


