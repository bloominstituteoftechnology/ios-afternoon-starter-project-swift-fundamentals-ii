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
    case enroute
    case scheduled
    case landed
    case cancelled
    case boarding
}

enum SecondayFlightStatus: String {
    case onTime
    case delayed
}

struct Airport {
    var name: String
    var callSign: String
    let city: String
}

struct Airline {
    var name: String
    var callSign: String
}

struct Flight {
    let flightNum: String
    let airline: Airline
    var primaryFlightStatus: FlightStatus
    var secondaryFlightStatus: SecondayFlightStatus?
    let destination: Airport
    let scheduledDepartureDate: DateComponents
    var terminal: String?
    var gate: String?
    
    //EVALUATE FLIGHT TIMES FOR NIL AND FORMAT IF NOT NIL
    func formatTime(flight: Flight) -> String {
        
        let returnString: String
        if flight.scheduledDepartureDate.hour != nil {
            switch flight.scheduledDepartureDate.minute {
            case 0, 1, 2, 3, 4, 5, 6, 7, 8, 9:
                returnString = "\(flight.scheduledDepartureDate.hour!):0\(flight.scheduledDepartureDate.minute!)"
            default:
                returnString = "\(flight.scheduledDepartureDate.hour!):\(flight.scheduledDepartureDate.minute!)"
            }
        } else {
            returnString = "Cancelled"
        }
        return returnString
    }
    
    //EVALUATE IF TERMINAL IS NIL AND RETURN VALUE
    func getTerminal(flight: Flight) -> String {
        var terminal: String
        if flight.terminal != nil{
            terminal = flight.terminal!
        } else {
            terminal = "TBD"
        }
        return terminal
    }
    
    //EVALUATE IF GATE IS NIL AND RETURN VALUE
    func getGate(flight: Flight) -> String {
        var gate: String
        if flight.gate != nil {
            gate = flight.gate!
        } else {
            gate = "TBD"
        }
        return gate
    }
    
    //EVALUATE SECONDARY STATUS FOR NIL AND RETURN VALUE
    func getStatus(flight: Flight) -> String {
        let status: String
        if flight.secondaryFlightStatus != nil {
            status = "\(flight.primaryFlightStatus.rawValue.capitalized) - \(flight.secondaryFlightStatus!.rawValue.capitalized)"
        } else {
            status = "\(flight.primaryFlightStatus.rawValue.capitalized)"
        }
        return status
    }
}

class DepartureBoard {
    let airport: Airport
    var flightList: [Flight]
    
    init(airport: Airport, flightList: [Flight]) {
        self.airport = airport
        self.flightList = flightList
    }
    
    //PASSENGER ALERTS
    func alertPassengers(flight: Flight) {
        switch flight.primaryFlightStatus {
        case .cancelled:
            print("We're sorry your flight to \(flight.destination.city) was canceled, here is a $500 voucher")
        case .scheduled:
            print("Your flight to \(flight.destination.city) is scheduled to depart at \(flight.formatTime(flight: flight)) from terminal: \(flight.getTerminal(flight: flight))")
        case .enroute:
            print("Flight: \(flight.airline.callSign) \(flight.flightNum) is currently En Route to \(flight.destination.city)")
        case .landed:
            print("Your flight has landed in \(flight.destination.city)")
        case .boarding:
            print("Your flight is now boarding. Please head to gate: \(flight.getGate(flight: flight))")
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
//DECLARE AIRLINES FOR FLIGHTS
let americanAirways = Airline(name: "American Airways", callSign: "AA")
let emirates =  Airline(name: "Emirates", callSign: "EK")
let royalAirMaroc = Airline(name: "Royal Air Maroc", callSign: "AT")

//DECLARE AIRPORTS FOR FLIGHTS
let jfk = Airport(name: "John F. Kennedy International", callSign: "JFK", city: "New York")
let dfw = Airport(name: "Dallas/Fort Worth International", callSign: "DFW", city: "Dallas")
let bos = Airport(name: "Logan International", callSign: "BOS", city: "Boston")
let cmn = Airport(name: "Mohamed V International", callSign: "CMN", city: "Casablanca")

//DECLARE FLIGHTS
let aa9250 = Flight(flightNum: "9250", airline: americanAirways, primaryFlightStatus: .scheduled, secondaryFlightStatus: .delayed, destination: dfw, scheduledDepartureDate: DateComponents(hour: 14, minute: 45), terminal: nil, gate: nil)
let ek6705 = Flight(flightNum: "6705", airline: emirates, primaryFlightStatus: .landed, secondaryFlightStatus: .onTime, destination: bos, scheduledDepartureDate: DateComponents(hour: 15, minute:10), terminal: "5", gate: "4")
let at203 = Flight(flightNum: "203", airline: royalAirMaroc, primaryFlightStatus: .cancelled, secondaryFlightStatus: nil, destination: cmn, scheduledDepartureDate: DateComponents(hour: nil, minute: nil), terminal: nil, gate: nil)

//DECLARE DEPARTURE BOARD
var departureBoard = DepartureBoard(airport: jfk, flightList: [])
departureBoard.flightList.append(aa9250)
departureBoard.flightList.append(ek6705)
departureBoard.flightList.append(at203)
//: ## 3. Create a free-standing function that can print the flight information from the `DepartureBoard`
//: a. Use the function signature: `printDepartures(departureBoard:)`
//:
//: b. Use a `for in` loop to iterate over each departure
//:
//: c. Make your `FlightStatus` enum conform to `String` so you can print the `rawValue` String values from the `enum`. See the [enum documentation](https://docs.swift.org/swift-book/LanguageGuide/Enumerations.html).
//:
//: d. Print out the current DepartureBoard you created using the function
func printDepartures(departureBoard: DepartureBoard) {
    print("___________________________JFK__DEPARTURES___________________________")
    print("  Destination  |     Airline     |  Flight  | Departure Time | Terminal | Gate |   Status   |")
    
    for flight in departureBoard.flightList {
        let destination: String = "\(flight.destination.city) (\(flight.destination.callSign))"
        let airline: String = "\(flight.airline.name)"
        let flightInfo: String = "\(flight.airline.callSign) \(flight.flightNum)"
        let departureTime: String = "\(flight.scheduledDepartureDate.hour):\(flight.scheduledDepartureDate.minute)"
        let terminal: String = "\(flight.getTerminal(flight: flight))"
        let gate: String = "\(flight.getGate(flight: flight))"
        let status: String = "\(flight.primaryFlightStatus.rawValue)"
        
        print("\(destination) | \(airline) | \(flightInfo) | \(departureTime) | \(terminal) | \(gate) | \(status)")
    }
}

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
func printDepartures2(departureBoard: DepartureBoard) {
    print("\n___________________________JFK__DEPARTURES___________________________")
    
    for flight in departureBoard.flightList {
        let destination: String = "\(flight.destination.city) (\(flight.destination.callSign))"
        let airline: String = "\(flight.airline.name)"
        let flightInfo: String = "\(flight.airline.callSign) \(flight.flightNum)"
        let departureTime: String = flight.formatTime(flight: flight)
        let terminal: String = flight.getTerminal(flight: flight)
        let gate: String = flight.getGate(flight: flight)
        let status: String = flight.getStatus(flight: flight)
        
        print("Destination: \(destination) | Airline: \(airline) | Flight: \(flightInfo) | Departure: \(departureTime) | Terminal: \(terminal) | Gate: \(gate) | Status: \(status)")
    }
}
printDepartures2(departureBoard: departureBoard)
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
//SEE DEPARTURE BOARD CLASS ABOVE AT LINE 114 FOR DECLARATION
for flight in departureBoard.flightList {
    departureBoard.alertPassengers(flight: flight)
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
func calculateAirfare(checkedBags: Int, distance: Int, travelers: Int) -> String {
    let bagCost: Int = 25  * checkedBags
    let mileCost: Double = 0.1 * Double(distance)
    let airFarePerPerson: Double = Double(bagCost) + mileCost
    let totalCost: Double = airFarePerPerson * Double(travelers)
    
    let currencyUSD = NumberFormatter()
    currencyUSD.usesGroupingSeparator = true
    currencyUSD.numberStyle = .currency
    currencyUSD.locale = Locale(identifier: "en_US")
    
    return currencyUSD.string(from: NSNumber(value: totalCost))!
}

print("Total cost for 3 passengers, with 2 bags each, travelling 2000 miles is: \(calculateAirfare(checkedBags: 2, distance: 2000, travelers: 3))")

print("Total cost for 5 passengers, with 1 bags each, travelling 1200 miles is: \(calculateAirfare(checkedBags: 1, distance: 1200, travelers: 5))")
