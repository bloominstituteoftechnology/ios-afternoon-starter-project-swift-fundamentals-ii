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
// for b - destination OR Arrival?
// Use a String? for the Terminal, since it may not be set yet (i.e.: waiting to arrive on time) - why not Int?

enum FlightStatus: String {
    case enRoute
    case enRouteDelayed
    case scheduled
    case scheduledOnTime // do i break down ontime vs regular vs delayed?
    case cancelled
    case delayed
    case boardingNow
}

var enroute = FlightStatus.enRoute
var enrouteDelayed = FlightStatus.enRouteDelayed
var scheduled = FlightStatus.scheduled
var scheduledOnTime = FlightStatus.scheduledOnTime
var cancelled = FlightStatus.cancelled
var delayed = FlightStatus.delayed
var boarding = FlightStatus.boardingNow

struct Airport {
    var cityname: String
    var airportCode: String
}

let airportNy = Airport(cityname: "New York", airportCode: "JFK")
let airportGa = Airport(cityname: "Atlanta", airportCode: "ATL")
let airportLax = Airport(cityname: "Los Angeles", airportCode: "LAX")
let airportOnt = Airport(cityname: "Ontario", airportCode: "ONT")

struct Flight {
    var airline: String
    var flightStatus: FlightStatus
    var flightNumber: String
    var departureTime: Date?
    var terminal: String?
    var destination: Airport
}

class DepartureBoard {
    var currentAirport: Airport
    var flights: [Flight]
    
    init(currentAirport: Airport, flights: [Flight] = []) {
        self.currentAirport = currentAirport
        self.flights = flights
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
var flight1 = Flight(airline: "Quantas", flightStatus: .enRouteDelayed, flightNumber: "QF 12", departureTime: Date(), terminal: "8", destination: airportLax)
var flight2 = Flight(airline: "Jet Blue", flightStatus: .enRouteDelayed, flightNumber: "B6 355", departureTime: Date(), terminal: "5", destination: airportOnt)
var flight3 = Flight(airline: "Delta Air", flightStatus: .cancelled, flightNumber: "DL 447", departureTime: Date(), terminal: "6", destination: airportLax)

var departures = DepartureBoard(currentAirport: airportNy)
departures.flights.append(flight1)
departures.flights.append(flight2)
departures.flights.append(flight3)

departures.flights[0].terminal = nil
departures.flights[2].flightStatus = .cancelled
departures.flights[2].departureTime = nil
//: ## 3. Create a free-standing function that can print the flight information from the `DepartureBoard`
//: a. Use the function signature: `printDepartures(departureBoard:)`
//:
//: b. Use a `for in` loop to iterate over each departure
//:
//: c. Make your `FlightStatus` enum conform to `String` so you can print the `rawValue` String values from the `enum`. See the [enum documentation](https://docs.swift.org/swift-book/LanguageGuide/Enumerations.html).
//:
//: d. Print out the current DepartureBoard you created using the function
func printDepartures(departureBoard: DepartureBoard) {
    for flightInfo in departureBoard.flights {
        print("Airline: \(flightInfo.airline), Flight Number: \(flightInfo.flightNumber), Destination: \(flightInfo.destination.cityname), Flight status: \(flightInfo.flightStatus.rawValue)")
    }
}
printDepartures(departureBoard: departures)




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
    for flightInfo in departureBoard.flights {
        var flightDepartureTimeString = ""
        var flightTerminalString = ""
        if let flightDepartureTime = flightInfo.departureTime {
            flightDepartureTimeString = "\(flightDepartureTime)"
        }
        if let flightTerminal = flightInfo.terminal {
            flightTerminalString = flightTerminal
        }
        print("Destination: \(flightInfo.destination) Airline: \(flightInfo.airline) \(flightInfo.flightNumber): \(flightDepartureTimeString): Terminal: \(flightTerminalString) Status: \(flightInfo.flightStatus)")
    }
}

printDepartures2(departureBoard: departures)


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
func alertPassengers() {
    for flightInfo in departures.flights {
        if let NewflightDepartureTime = flightInfo.departureTime {
            switch flightInfo.flightStatus {
            case .cancelled:
                print("We're sorry your flight to \(flightInfo.destination) was canceled, here is a $500 voucher")
            case .scheduledOnTime:
                print("Your flight to \(flightInfo.destination) is scheduled to depart at \(flightInfo.departureTime) from terminal: \(flightInfo.terminal)")
            case .boardingNow:
                print("Your flight is boarding, please head to terminal: \(flightInfo.terminal) immediately. The doors are closing soon.")
            default:
                print("Thank you for flying with us")
            }
        }
    }
}
alertPassengers()




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
func totalAirfair(checkedBags: Int, distance: Int, travelers: Int) -> Double {
    let checkedBagCost: Int = 25
    let costPerMi: Double = 0.10
    
    let baggageCost = checkedBagCost * checkedBags
    let milageCost = Double(distance) * costPerMi
    let costPerPassenger = Double(baggageCost) + milageCost
    let totalCost = costPerPassenger * Double(travelers)
    
    return totalCost
}

// currency Formatter

let RevisedTotalAirfair = totalAirfair(checkedBags: 4, distance: 2000, travelers: 6)
let dollarFormatter = NumberFormatter()
dollarFormatter.usesGroupingSeparator = true
dollarFormatter.currencyCode = "USD"
dollarFormatter.numberStyle = .currency
dollarFormatter.locale = .current

let newValue =  NSNumber(value: RevisedTotalAirfair)
let finalTicketCost = dollarFormatter.string(from: newValue)




