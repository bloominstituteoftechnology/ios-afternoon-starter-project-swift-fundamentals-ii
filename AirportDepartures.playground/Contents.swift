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
    case enRoute, onTime, cancelled, sheduled, delayed
}

enum AirportType {
    case destination
    case arrival
}

struct Airport {
    let name: String
    let type: AirportType
}

struct Flight {
    let date: Date?
    let terminal: String?
    let flightStatus: FlightStatus
}

class DepartureBoard {
    let flights: [Flight]
    let airport: Airport
    
    init(flights: [Flight], airport: Airport) {
        self.flights = flights
        self.airport = airport
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
// Create custom date from components
var dateComponents = DateComponents()
dateComponents.year = 2020
dateComponents.month = 8
dateComponents.day = 11
dateComponents.timeZone = TimeZone(abbreviation: "JST")
dateComponents.hour = 8
dateComponents.minute = 34
let userCalendar = Calendar.current
let someDateTime = userCalendar.date(from: dateComponents)

// Initializing of flights array
var flights: [Flight] = []

// Creating flights
let firtsFlight = Flight(date: Date(), terminal: "Terminal 01", flightStatus: .enRoute)
let secondFlight = Flight(date: nil, terminal: nil, flightStatus: .cancelled)
let thirdFlight = Flight(date: someDateTime, terminal: "Terminal 03", flightStatus: .delayed)

// Add flights into array for the board
flights.append(firtsFlight)
flights.append(secondFlight)
flights.append(thirdFlight)

// Create airport
let airport = Airport.init(name: "John Kennedy", type: .arrival)

// Create board
let departureBoard = DepartureBoard(flights: flights, airport: airport)
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
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm, d MMM y"
        var dateString = ""
        if let date = flight.date {
            dateString = formatter.string(from: date)
        }
        var flightTerminal = ""
        if let terminal = flight.terminal {
            flightTerminal = terminal
        }
        print("Flight from terminal: \(flightTerminal) \n with Status: \(flight.flightStatus), \n with Date: \(dateString), from \(departureBoard.airport.type) Airport named: \(departureBoard.airport.name)")
    }
}
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
 // it was done in scope of third step
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
extension DepartureBoard {
     func allPassengersAlert() {
        
        /*
        Note
        I created not very correct 'Flight' structure because of misunderstanding of the task
        I will use airport from departure board instead of city name of the flight
        */
        
        let airportName = self.airport.name

        for flight in self.flights {

            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm, d MMM y"
            var time = "TBD"
            if let date = flight.date {
                time = formatter.string(from: date)
            }

            var terminal = "Information unavailable. Please visit the nearest information desk for more details"
            if let term = flight.terminal {
                terminal = term
            }
            
            switch flight.flightStatus {
            case .cancelled:
                print("We're sorry your flight to \(airportName) was canceled, here is a $500 voucher")
            case .sheduled:
                print("Your flight to \(airportName) is scheduled to depart at \(time) from terminal: \(terminal)")
            case .enRoute: // I have no 'boarding' so I will use it here
                print("Your flight is boarding, please head to terminal: \(terminal) immediately. The doors are closing soon.")
            case .onTime:
                print("Your flight to \(airportName) is on time to depart at \(time) from terminal: \(terminal)")
            case .delayed :
                print("We're sorry your flight to \(airportName) is delayed, here is a $500 voucher")
            }
        }
    }
}

departureBoard.allPassengersAlert()
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
func calculateAirfare(checkedBags: Int, distance: Int, travelers: Int, ticketCost: Double) -> Double {
    let bagCost = 25.0
    let mileCost = 0.1
    
    var airfare = 0.0
    airfare += Double(checkedBags) * bagCost
    airfare += mileCost * Double(distance)
    airfare += Double(travelers) * ticketCost

    return airfare
}

// Setup formatter
let formatter = NumberFormatter()
formatter.numberStyle = .currency
formatter.currencyCode = "USD"
formatter.currencySymbol = "$"
formatter.maximumFractionDigits = 0

// Calculate airfare
let airfare = calculateAirfare(checkedBags: 3, distance: 1200, travelers: 5, ticketCost: 250)

var resultString = ""
if let formattedAirfare = formatter.string(from: NSNumber(value: airfare)) {
    resultString = formattedAirfare
}

print(resultString)

