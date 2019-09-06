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

let dateFormatter = DateFormatter()
dateFormatter.dateStyle = .none
dateFormatter.timeStyle = .short

struct Airport {
    let name: String
}

struct Flight {
    let departureTime: Date?
    let terminal: String?
    let destination: Airport
    let airline: String
    let flightStatus: FlightStatus
    let flightNumber: String
}

enum FlightStatus: String {
    case enRoute
    case scheduled
    case cancelled
    case delayed
    case boarding
}

class DepartureBoard {
    var currentAirport: String
    private (set) var flights: [Flight]
    
    init(currentAirport: String) {
        self.currentAirport = currentAirport
        flights = []
    }
    
    func add(flight: Flight) {
        flights.append(flight)
    }
    
    func alertPassengers() {
        
        for flight in flights {
            
            var dateToString: String
            if flight.departureTime != nil {
                dateToString = dateFormatter.string(from: flight.departureTime!)
            } else {
                dateToString = "TBD"
            }
            
            
            switch flight.flightStatus {
            case .cancelled:
                print("We're sorry your flight to \(flight.destination.name) was canceled, here is a $500 voucher")
            case .scheduled:
                print("Your flight to \(flight.destination.name) is scheduled to depart at \(dateToString) from terminal: \(flight.terminal ?? "TBD")")
            case .boarding:
                print("Your flight is boarding, please head to terminal: \(flight.terminal ?? "TBD") immediately. The doors are closing soon.")
            case .enRoute:
                print("Your flight \(flight.flightNumber) is en route to \(flight.destination.name).")
            case .delayed:
                print("Your flight \(flight.flightNumber) to \(flight.destination.name) at \(dateToString) has been delayed.")
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
let myFirstFlight = Flight(departureTime: Date(),
                           terminal: "A",
                           destination: Airport(name: "Tokyo"),
                           airline: "ANA",
                           flightStatus: (.scheduled),
                           flightNumber: "NH 9")
let mySecondFlight = Flight(departureTime: nil,
                            terminal: "B",
                            destination: Airport(name: "Toronto"),
                            airline: "Envoy Air",
                            flightStatus: (.cancelled),
                            flightNumber: "MQ 3957")
let myThirdFlight = Flight(departureTime: Date(),
                           terminal: nil,
                           destination: Airport(name: "Burlington"),
                           airline: "Air France",
                           flightStatus: .enRoute,
                           flightNumber: "9E 5120")

let firstDepartureBoard = DepartureBoard(currentAirport: "JKF")

firstDepartureBoard.add(flight: myFirstFlight)
firstDepartureBoard.add(flight: mySecondFlight)
firstDepartureBoard.add(flight: myThirdFlight)


//: ## 3. Create a free-standing function that can print the flight information from the `DepartureBoard`
//: a. Use the function signature: `printDepartures(departureBoard:)`
//:
//: b. Use a `for in` loop to iterate over each departure
//:
//: c. Make your `FlightStatus` enum conform to `String` so you can print the `rawValue` String values from the `enum`. See the [enum documentation](https://docs.swift.org/swift-book/LanguageGuide/Enumerations.html).
//:
//: d. Print out the current DepartureBoard you created using the function
func printDepartures(departureBoard: DepartureBoard) {
    for flight in departureBoard.flights {
        if let time = flight.departureTime {
            let dateToString = dateFormatter.string(from: time)
            print("Destination: \(flight.destination.name) Airline: \(flight.airline) Flight: \(flight.flightNumber) Departure Time: \(dateToString) Terminal: \(flight.terminal ?? "") Status: \(flight.flightStatus)")
        } else {print("Destination: \(flight.destination.name) Airline: \(flight.airline) Flight: \(flight.flightNumber) Departure Time:  Terminal: \(flight.terminal ?? "") Status: \(flight.flightStatus)")}
    }
}

printDepartures(departureBoard: firstDepartureBoard)



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

// I modified step 3's printDepartures instead of making printDepartures2
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
firstDepartureBoard.alertPassengers()



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
    
    let bag: Double = 25
    let costPerMile: Double = 0.10
    
    let bagTotal: Double = bag * Double(checkedBags)
    let distanceTotal: Double = costPerMile * Double(distance)
    let bagAndDistanceTotal: Double = bagTotal + distanceTotal
    let travelerTotal: Double = bagAndDistanceTotal * Double(travelers)
    return travelerTotal
}

calculateAirfare(checkedBags: 2, distance: 2000, travelers: 3)

