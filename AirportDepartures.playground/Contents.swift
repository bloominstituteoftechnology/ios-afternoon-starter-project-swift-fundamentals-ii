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
    case enroute = "En Route"
    case scheduled = "Scheduled"
    case canceled = "Canceled"
    case delayed = "Delayed"
    case onboarding = "Boarding"
}
struct Airport {
    let name: String
    let address: String
}
struct Flight {
    var name: String
    var destination: String
    var date: Date?
    var Terminal: String? //typo should be terminal
    var flightstatus: FlightStatus //typo should be flightStatus

}

class DepatureBoard {
    var departureFlight: [Flight]
    var airport: Airport
    
    init(departureFlight: [Flight], airport: Airport) {
        self.departureFlight = departureFlight
        self.airport = airport
    }
    
    func alertPassengers(flight: [Flight]) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .short
        
        for individule in flight {
            switch individule.flightstatus {
            case .canceled:
                print("We're sorry your flight to \(individule.destination) was canceled, here is a $500 voucher")
            case .scheduled:
                if let suredDate = individule.date, let suredTerminal = individule.Terminal {
                    print("Your flight to \(individule.destination) is scheduled to depart at \(dateFormatter.string(from: suredDate)) from terminal: \(suredTerminal)")
                } else if let suredDate = individule.date, individule.Terminal == nil {
                    print("Your flight to \(individule.destination) is scheduled to depart at \(dateFormatter.string(from: suredDate)) from terminal: TBD")
                } else if let suredTerminal = individule.Terminal, individule.date == nil {
                    print("Your flight to \(individule.destination) is scheduled to depart at TBD from terminal: \(suredTerminal)")
                } else {
                    print("Your flight to \(individule.destination) is scheduled to depart at TBD from terminal: TBD")
                }
            case .onboarding:
                if let sureTerminal = individule.Terminal {
                    print("Your flight is boarding, please head to terminal: \(sureTerminal) immediately. The doors are closing soon.")
                } else {
                    print("Your flight is boarding, please head to terminal: TBD immediately. The doors are closing soon.")
                }
            case .delayed:
                print("Your flight is to \(individule.destination) is delayed.")
            default:
                print("Your flight is on the way.")
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
let flight_1 = Flight(name: "A456", destination: "Japan", date: Date(), Terminal: "1", flightstatus: .scheduled)
let flight_2 = Flight(name: "B789", destination:"New York", date: Date(), Terminal: nil, flightstatus: .delayed)
let flight_3 = Flight(name: "C000",destination:"Shanghai",date: nil, Terminal: "3", flightstatus: .canceled)
var threeFlights: [Flight] = []
threeFlights.append(contentsOf: [flight_1, flight_2,flight_3])

//: ## 3. Create a free-standing function that can print the flight information from the `DepartureBoard`
//: a. Use the function signature: `printDepartures(departureBoard:)`
//:
//: b. Use a `for in` loop to iterate over each departure
//:
//: c. Make your `FlightStatus` enum conform to `String` so you can print the `rawValue` String values from the `enum`. See the [enum documentation](https://docs.swift.org/swift-book/LanguageGuide/Enumerations.html).
//:
//: d. Print out the current DepartureBoard you created using the function
func printDepartures(departureBoard: DepatureBoard) {
    for departure in departureBoard.departureFlight {
        print("Name: \(departure.name), Destination: \(departure.destination), Date: \(departure.date), Terminal: \(departure.Terminal), Flight Status: \(departure.flightstatus.rawValue)")
    }
}
let myAirport = Airport(name: "JFK",address: "123 Maple St, Buffalo, NY, 14228")
let myFlight = threeFlights
let myDepart = DepatureBoard(departureFlight: myFlight, airport: myAirport)
printDepartures(departureBoard: myDepart)
print(" ")
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
func printDepartures2(departureBoard: DepatureBoard) {
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .none
    dateFormatter.timeStyle = .short
    
    for departure in departureBoard.departureFlight {
        dateFormatter.locale = Locale(identifier: "en_US")
        if let actualDate = departure.date, let actualTerminal = departure.Terminal {
            print("Name: \(departure.name), Destination: \(departure.destination), Date: \(dateFormatter.string(from: actualDate)), Terminal: \(actualTerminal), Flight Status: \(departure.flightstatus.rawValue)")
        } else if let actualTerminal = departure.Terminal, departure.date == nil {
            print("Name: \(departure.name), Destination: \(departure.destination), Date:  , Terminal: \(actualTerminal), Flight Status: \(departure.flightstatus.rawValue)")
        } else if let actualDate = departure.date, departure.Terminal == nil {
            print("Name: \(departure.name), Destination: \(departure.destination), Date: \(dateFormatter.string(from: actualDate)), Terminal:  , Flight Status: \(departure.flightstatus.rawValue)")
        } else {
            print("Name: \(departure.name), Destination: \(departure.destination), Date:  , Terminal:  , Flight Status: \(departure.flightstatus.rawValue)")
        }
    }
} // What if I want to output nil to something else? Then the else ifs will be more!
let myAirport2 = Airport(name: "JFK",address: "123 Maple St, Buffalo, NY, 14228")
let myFlight2 = threeFlights
let myDepart2 = DepatureBoard(departureFlight: myFlight2, airport: myAirport2)
printDepartures2(departureBoard: myDepart2)
print(" ")


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

myDepart2.alertPassengers(flight: threeFlights)
print(" ")
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
    var bagCosts: Int = checkedBags * 25
    var mileCost: Double = Double(distance) * 0.10
    var ticketCost = travelers * 250
    let total: Double = Double(bagCosts) + mileCost + Double(ticketCost)
    
    func convertDoubleToCurrency(amount: Double) -> String {  //convert
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.locale = Locale.current
        
        return numberFormatter.string(from: NSNumber(value: total))!  //force unwrap
    }
    let result = convertDoubleToCurrency(amount: total)
    print("Your total cost will be \(result).")
    return total
}
calculateAirfare(checkedBags: 2, distance: 2000, travelers: 3)

