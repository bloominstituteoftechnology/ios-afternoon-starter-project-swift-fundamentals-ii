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


// 1.a
enum FlightStatus: String {
    case Scheduled = "Scheduled"
    case Boarding = "Boarding"
    case En_Route = "En Route"
    case Delayed = "Delayed"
    case Canceled = "Canceled"
    case Landed = "Landed"
    case On_Time = "On Time"
}
// 1.b
struct Airport {
    let name: String
}
// 1.c, d, e
struct Flight {
    let destination: Airport
    var departureTime: Date?
    var terminal: String?
    var flightStatus: FlightStatus
}
// 1.f
class DepartureBoard {
    var currentAirport: String
    var flights: [Flight]
    
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
            case .Canceled:
                print("We're sorry, the flight to \(flight.destination.name) was canceled.")
            case .Scheduled:
                if flight.terminal != nil {
                    print("The flight to \(flight.destination.name) is scheduled to depart at \(dateToString) from terminal: \(flight.terminal ?? "TBD")")
                } else {
                    print("The flight to \(flight.destination.name) is scheduled to depart at \(dateToString).  Please see the front desk for terminal change information.")
                }
            case .Boarding:
                 if flight.terminal != nil {
                    print("The flight is boarding, please head to terminal: \(flight.terminal ?? "TBD") immediately. The doors are closing soon.")
                } else {
                    print("The flight is boarding, please head to the front desk for terminal change information.")
                    
                }
            case .En_Route:
                print("The flight is en route to \(flight.destination.name).")
            case .Delayed:
                print("The flight to \(flight.destination.name) at \(dateToString) has been delayed.")
            case .Landed:
                if flight.terminal != nil {
                    print("The flight to \(flight.destination.name) has landed, and will begin boarding soon.  Please proceed to terminal \(flight.terminal ?? "TBD") immediately.")
                } else {
                    print("The flight to \(flight.destination.name) has landed, and will begin boarding soon.  Please proceed to the front desk for terminal change information.")
                }
            case .On_Time:
                print("The flight to \(flight.destination.name) will be arriving at \(dateToString) as scheduled.")
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
// 2.a
let flight1 = Flight(destination: Airport(name: "Manchester"),
                           departureTime: Date(),
                           terminal: "A",
                           flightStatus: (.Scheduled))

let flight2 = Flight(destination: Airport(name: "Atlanta"),
                     departureTime: nil,
                     terminal: "A",
                     flightStatus: (.Canceled))
let flight3 = Flight(destination: Airport(name: "Los Angeles"),
                     departureTime: Date(),
                     terminal: nil,
                     flightStatus: (.Scheduled))

let departureBoard1 = DepartureBoard(currentAirport: "JKF")

departureBoard1.add(flight: flight1)
departureBoard1.add(flight: flight2)
departureBoard1.add(flight: flight3)

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
            print("Destination: \(flight.destination.name) Departure Time: \(dateToString) Terminal: \(flight.terminal ?? "TBD") Status: \(flight.flightStatus)")
        } else {print("Destination: \(flight.destination.name) Departure Time: TBD Terminal: \(flight.terminal ?? "TBD") Status: \(flight.flightStatus)")}
    }
}

printDepartures(departureBoard: departureBoard1)
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
departureBoard1.alertPassengers()


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
    print("The total airfare for \(travelers) travelers who are traveling \(distance) miles with \(checkedBags) bags is $\(travelerTotal).")
    return travelerTotal
}

calculateAirfare(checkedBags: 2, distance: 2000, travelers: 3)
calculateAirfare(checkedBags: 5, distance: 1500, travelers: 4)


