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
// a. Use an enum type for the FlightStatus (En Route, Scheduled, Canceled, Delayed, etc.)
// c. Make your FlightStatus enum conform to String so you can print the rawValue String values from the enum. See the enum documentation.

enum FlightStatus: String {
    case En_Route = "En Route"
    case Landed = "Landed"
    case Scheduled = "Scheduled"
    case Canceled = "f"
    case On_Time = "On Time"
    case Delayed = "Delayed"
    case Boarding = "Boarding"
}


// b. Use a struct to represent an Airport (Destination or Arrival)

struct Airport {
    let name: String
    let type: String
}



// c. Use a struct to represent a Flight.
// d. Use a Date? for the departure time since it may be canceled.
// e. Use a String? for the Terminal, since it may not be set yet (i.e.: waiting to arrive on time)

struct Flight {
    let destination: Airport
    let flightStatus: FlightStatus
    let flightNumber: String
    let terminal: String?
    let arrivalTime: Date?
    let departureTime: Date?
    
}

// f. Use a class to represent a DepartureBoard with a list of departure flights, and the current airport

class DepartureBoard {
    var flights: [Flight]
    var airline: [String]
    
    init() {
        self.airline = []
        self.flights = []
    }
    
    // This is a method within the class
    func alertPassengers() {
        for flight in self.flights{

            var uwTime: String
            var uwTerm: String
            if let uwDepartureTime = flight.departureTime {
                uwTime = "\(uwDepartureTime)"
            } else {
                uwTime = "TBD"
            }

            if let uwTerminal = flight.terminal {
                uwTerm = "\(uwTerminal)"
            } else {
                uwTerm = "TBD"
                print("Go to the nearest information desk for more details.")
            }

            switch flight.flightStatus {
            case .Canceled:
                print("We're sorry your flight to \(flight.destination.name) was canceled, here is a $500 voucher")
            case .Scheduled:
                print("Your flight to \(flight.destination.name) is scheduled to depart at \(uwTime) from terminal: \(uwTerm)")
            case .Boarding:
                print("Your flight is boarding, please head to terminal: \(uwTerm) immediately. The doors are closing soon.")
            default:
                print("Sorry for the inconvenience.")
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
// a. For the departure time, use Date() for the current time
// c. Make one of the flights .canceled with a nil departure time
// d. Make one of the flights have a nil terminal because it has not been decided yet.

let flight1 = Flight(destination: .init(name: "Dallas - DFW", type: "Destination"), flightStatus: .On_Time, flightNumber: "NH 9000", terminal: "7", arrivalTime: Date(), departureTime: nil)

let flight2 = Flight(destination: .init(name: "New York - JFK", type: "Arrival"), flightStatus: .Delayed, flightNumber: "UA 7998", terminal: nil, arrivalTime: Date(), departureTime: Date())

let flight3 = Flight(destination: .init(name: "Dallas - DFW", type: "Arrival"), flightStatus: .On_Time, flightNumber: "NH 8000", terminal: "7", arrivalTime: Date(), departureTime: Date())


// b. Use the Array append() method to add Flight's
let departureBoard =  DepartureBoard()
departureBoard.flights.append(flight1)
departureBoard.flights.append(flight2)
departureBoard.flights.append(flight3)




// e. Stretch: Look at the API for DateComponents for creating a specific time


//: ## 3. Create a free-standing function that can print the flight information from the `DepartureBoard`
//: a. Use the function signature: `printDepartures(departureBoard:)`
//:
//: b. Use a `for in` loop to iterate over each departure
//:
//: c. Make your `FlightStatus` enum conform to `String` so you can print the `rawValue` String values from the `enum`. See the [enum documentation](https://docs.swift.org/swift-book/LanguageGuide/Enumerations.html).
//:
//: d. Print out the current DepartureBoard you created using the function
// a. Use the function signature: printDepartures(departureBoard:)
// b. Use a for in loop to iterate over each departure
// d. Print out the current DepartureBoard you created using the function

func printDepartures(departureBoard: DepartureBoard) {
    for flight in departureBoard.flights{
        flight.flightStatus.rawValue
        
        var uwTime: String
        var uwTerm: String
        if let uwDepartureTime = flight.departureTime {
            uwTime = "\(uwDepartureTime)"
        } else {
            uwTime = "TBD"
        }
        
        if let uwTerminal = flight.terminal {
            uwTerm = "\(uwTerminal)"
        } else {
            uwTerm = "TBD"
        }
    
        print("""
            Destination: \(flight.destination.name)\t\tFlight#: \(flight.flightNumber)\t\tDeparture Time: \(uwTime)\tTerminal: \(uwTerm)
            """)
    }
}

func calculateAirfare(checkedBags: Int, distance: Int, travelers: Int) -> Double {
    
    let bagCost = Double(checkedBags) * 25
    let airfare = Double(distance) * 0.10
    let ticket = Double(travelers) + Double(airfare) + bagCost
    
    return ticket
}

// This formats the string
let currencyFormatter = NumberFormatter()
currencyFormatter.usesGroupingSeparator = true
currencyFormatter.numberStyle = .currency
// currencyFormatter.numberStyle = NumberFormatter.Style.currency

currencyFormatter.locale = .current



printDepartures(departureBoard: departureBoard)
//alertPassengers(departureBoard: departureBoard)

// The reason I can call .alertPassengers() is because it is an instance method and methods can be accessed through the dot notation
departureBoard.alertPassengers()
let ticketCost = calculateAirfare(checkedBags: 3, distance: 2000, travelers: 3)
let nsNumber = NSNumber(value: ticketCost)

let ticketPrice = currencyFormatter.string(from: nsNumber)
guard let ticketPrice = ticketPrice else {
    print("Sorry, your ticket is free.")
    fatalError()
}

ticketPrice


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



