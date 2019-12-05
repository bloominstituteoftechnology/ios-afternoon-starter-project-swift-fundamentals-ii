import UIKit

struct Airport {
    let name: String
    let code: String
}

let jfk = Airport(name: "John F. Kennedy", code: "JFK")
let lax = Airport(name: "Los Angeles Intl Airport", code: "LAX")
let ord = Airport(name: "Chicago O'hare Intl Airport", code: "ORD")

struct Flights {
    enum Status: String {
        case EnRoute
        case Scheduled
        case Delayed
        case Cancelled
        case Boarding
    }
    
    let departureTime: Date?
    let terminal: String?
    let airlineName: String
    let destination: Airport
    let flightStatus: Status
}

let calender = Calendar.current
let date = calender.date(byAdding: DateComponents(year: 1), to: Date())

let flight1 = Flights(departureTime: date, terminal: nil, airlineName: "Spirit", destination: lax, flightStatus: .Delayed)
let flight2 = Flights(departureTime: nil, terminal: "4", airlineName: "United", destination: jfk, flightStatus: .Cancelled)
let flight3 = Flights(departureTime: nil, terminal: "1", airlineName: "American", destination: ord, flightStatus: .Scheduled)
let flight4 = Flights(departureTime: date, terminal: "3", airlineName: "JetBlue", destination: ord, flightStatus: .Boarding)

class DepartureBoard {
    var departureFlights: [Flights] = []
    let currentAirport: Airport
    
    init(currentAirport: Airport) {
        self.currentAirport = currentAirport
    }
    
    func alertPassengers() {
        for flight in departureFlights {
            var finalDate: String?
            if let unwrappedDate = flight.departureTime {
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateStyle = .none
                dateFormatter.timeStyle = .short
                dateFormatter.locale = .current
                
                finalDate = dateFormatter.string(from: unwrappedDate)
            }
            
            switch flight.flightStatus {
            case .Cancelled:
                print("We're sorry your flight to \(flight.destination.name) was canceled, here is a $500 voucher")
            case .Scheduled:
                print("Your flight to \(flight.destination.name) is scheduled to depart at \(finalDate ?? "TBD") from Terminal: \(flight.terminal ?? "TBD")")
            case .Boarding:
                print("Your flight is boarding, please head to Terminal: \(flight.terminal ?? "TBD"). The doors are closing soon.")
            case .Delayed:
                print("Your flight is currently delayed.")
            default:
                break
            }
        }
    }
}

let board = DepartureBoard(currentAirport: lax)
board.departureFlights.append(contentsOf: [flight1, flight2, flight3, flight4])
board.alertPassengers()

func printDepartures(departureBoard: DepartureBoard) {
    
    for flight in board.departureFlights {
        
        var finalDate = ""
        var finalTerminal = ""

        if let unwrappedDate = flight.departureTime {
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .none
            dateFormatter.timeStyle = .short
            dateFormatter.locale = .current
            
            finalDate = dateFormatter.string(from: unwrappedDate)
        }
        
        if let unwrappedTerminal = flight.terminal {
            finalTerminal = "\(unwrappedTerminal)"
        }
        
        print("Destination: \(flight.destination.name) Name: \(flight.airlineName) Time: \(finalDate) Terminal: \(finalTerminal) Status: \(flight.flightStatus.rawValue),")
    }
}
printDepartures(departureBoard: board)


func calculateAirfare(checkedBags: Int, distance: Int, travelers: Int) -> Double {
    
    // cost of bag and mileage
    let bag = 25.0
    let mile = 0.10
    
    // calculation for each airfare
    let distanceCost = Double(distance) * mile
    let bagCost = Double(checkedBags) * bag
    let totalPrice = (distanceCost + bagCost) * Double(travelers)
    
    let currencyFormatter = NumberFormatter()
    currencyFormatter.numberStyle = .currency
    
    if let price = currencyFormatter.string(from: NSNumber(value: totalPrice)) {
        print(price)
    }
    return totalPrice
}
calculateAirfare(checkedBags: 2, distance: 2000, travelers: 3)
calculateAirfare(checkedBags: 9, distance: 4000, travelers: 4)

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



/// *** ADDED THIS ABOVE ***




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


/// *** ADDED THIS ABOVE ***



//: ## 3. Create a free-standing function that can print the flight information from the `DepartureBoard`
//: a. Use the function signature: `printDepartures(departureBoard:)`
//:
//: b. Use a `for in` loop to iterate over each departure
//:
//: c. Make your `FlightStatus` enum conform to `String` so you can print the `rawValue` String values from the `enum`. See the [enum documentation](https://docs.swift.org/swift-book/LanguageGuide/Enumerations.html).
//:
//: d. Print out the current DepartureBoard you created using the function


/// *** ADDED THIS ABOVE ***



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


/// *** ADDED THIS ABOVE ***


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


/// ***ADDED THIS ABOVE***

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

/// *** ADDED THIS ABOVE***
