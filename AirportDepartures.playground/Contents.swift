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
    case enRouteOnTime = "En Route - On Time"
    case enRouteDelayed = "En Route - Delayed"
    case scheduled = "Scheduled"
    case canceled = "Canceled"
    case landedOnTime = "Landed - On Time"
    case landedDelayed = "Landed - Delayed"
    case boarding = "Boarding Now"
}

struct Airport {
    let name: String
    let city: String
    let initials: String
    
    init(name: String, city: String, initials: String) {
        self.name = name
        self.city = city
        self.initials = initials
    }
}

struct Flight {
    let flightNumber: String
    let destination: Airport
    let departureTime: Date?
    let airline: String
    var flightStatus: FlightStatus
    var terminal: String?
    
    init(flightNumber: String,
         destination: Airport,
         departureTime: Date? = nil,
         airline: String,
         flightStatus: FlightStatus,
         terminal: String? = nil) {
        self.flightNumber = flightNumber
        self.destination = destination
        self.departureTime = departureTime
        self.airline = airline
        self.flightStatus = flightStatus
        self.terminal = terminal
    }
}

class DepartureBoard {
    var departures: [Flight]
    let currentAirport: Airport
    
    init(departures: [Flight] = [], from currentAirport: Airport) {
        self.departures = departures
        self.currentAirport = currentAirport
    }
    
    func alertPassengers(departureBoard: DepartureBoard) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .short
        for flight in departureBoard.departures {
            let status = flight.flightStatus
            let city = flight.destination.city
            var time: String
            var terminal: String
            if let unWrappedTime = flight.departureTime {
                time = dateFormatter.string(from: unWrappedTime)
            } else {
                time = "TBD"
            }
            if let unWrappedTerminal = flight.terminal {
                terminal = unWrappedTerminal
            } else {
                terminal = "TBD"
            }
            if terminal != "TBD" {
                switch status {
                case .enRouteDelayed, .landedDelayed:
                    print("Your flight to \(city) is delayed. It is now sheduled to depart at \(time) from terminal: \(terminal)")
                case .scheduled, .enRouteOnTime, .landedOnTime:
                    print("Your flight to \(city) is scheduled to depart at \(time) from terminal: \(terminal)")
                case .canceled:
                    print("We're sorry your flight to \(city) was canceled, here is a $500 voucher")
                default:
                    print("Your flight is boarding, please head to terminal: (terminal) immediately. The doors are closing soon.")
                }
            } else {
                print("Your terminal is not assigned yet. Please see the nearest information desk for assitance.")
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
let jfk = Airport(name: "JFK International Airport",
                         city: "New York, NY",
                         initials: "JFK")
let oHare = Airport(name: "O'Hare International Airport",
                    city: "Chicago, IL",
                    initials: "ORD")
let heathrow = Airport(name: "London Heathrow Airport",
                              city: "London, UK",
                              initials: "LHR")
let tampa = Airport(name: "Tampa International Airport",
                    city: "Tampa, FL",
                    initials: "TIA")

let calendar = Calendar.current
var time1 = DateComponents()
time1.hour = 7
time1.minute = 25
var time2 = DateComponents()
time2.hour = 8
time2.minute = 10
let time1111 = calendar.date(from: time1)
let time2222 = calendar.date(from: time2)

var flight1111 = Flight(flightNumber: "US 1111",
                        destination: jfk,
                        departureTime: time1111,
                        airline: "SouthWest Airlines",
                        flightStatus: .enRouteOnTime,
                        terminal: "3")
var flight2222 = Flight(flightNumber: "US 2222",
                        destination: heathrow,
                        departureTime: time2222,
                        airline: "American Airlines",
                        flightStatus: .enRouteDelayed,
                        terminal: nil)
var flight3333 = Flight(flightNumber: "US 3333",
                        destination: tampa,
                        departureTime: nil,
                        airline: "SouthWEst Airlines",
                        flightStatus: .canceled,
                        terminal: "4")
var jfkDepartures: [Flight] = []
var jfkDepartureBoard = DepartureBoard(departures: jfkDepartures, from: jfk)
jfkDepartureBoard.departures.append(flight1111)
jfkDepartureBoard.departures.append(flight2222)
jfkDepartureBoard.departures.append(flight3333)

//: ## 3. Create a free-standing function that can print the flight information from the `DepartureBoard`
//: a. Use the function signature: `printDepartures(departureBoard:)`
//:
//: b. Use a `for in` loop to iterate over each departure
//:
//: c. Make your `FlightStatus` enum conform to `String` so you can print the `rawValue` String values from the `enum`. See the [enum documentation](https://docs.swift.org/swift-book/LanguageGuide/Enumerations.html).
//:
//: d. Print out the current DepartureBoard you created using the function
func printDepartures(departureBoard: DepartureBoard) {
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .none
    dateFormatter.timeStyle = .short
    for flight in departureBoard.departures {
        if let unWrappedTime = flight.departureTime, let unWrappedTerminal = flight.terminal {
            let dateString: String = dateFormatter.string(from: unWrappedTime)
            print("Destination: \(flight.destination.city), Airline: \(flight.airline), Flight Number: \(flight.flightNumber), Departure Time: \(dateString), Terminal: \(unWrappedTerminal), Status: \(flight.flightStatus.rawValue)")
        } else if let unWrappedTime = flight.departureTime {
            let dateString: String = dateFormatter.string(from: unWrappedTime)
            print("Destination: \(flight.destination.city), Airline: \(flight.airline), Flight Number: \(flight.flightNumber), Departure Time: \(dateString), Terminal: Not Assigned, Status: \(flight.flightStatus.rawValue)")
        } else if let unWrappedTerminal = flight.terminal {
            print("Destination: \(flight.destination.city), Airline: \(flight.airline), Flight Number: \(flight.flightNumber), Departure Time:  , Terminal: \(unWrappedTerminal), Status: \(flight.flightStatus.rawValue)")
        } else {
            print("Destination: \(flight.destination.city), Airline: \(flight.airline), Flight Number: \(flight.flightNumber), Departure Time:  , Terminal: Not Assigned , Status: \(flight.flightStatus.rawValue)")
        }
    }
}

printDepartures(departureBoard: jfkDepartureBoard)

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
// modified previous function so previous function call now displays output per this element


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
jfkDepartureBoard.alertPassengers(departureBoard: jfkDepartureBoard)



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
    let bagCost = 25.00
    let mileCost = 0.10
    let costPerPerson = (bagCost * Double(checkedBags)) + (mileCost * Double(distance))
    return costPerPerson * Double(travelers)
}

let formatter = NumberFormatter()
formatter.numberStyle = .currency

let airfare1 = calculateAirfare(checkedBags: 2, distance: 645, travelers: 1)
print(formatter.string(from: NSNumber(value: airfare1))!)
let airfare2 = calculateAirfare(checkedBags: 1, distance: 1236, travelers: 2)
print(formatter.string(from: NSNumber(value: airfare2))!)
let airfare3 = calculateAirfare(checkedBags: 0, distance: 340, travelers: 5)
print(formatter.string(from: NSNumber(value: airfare3))!)
let airfare4 = calculateAirfare(checkedBags: 2, distance: 2000, travelers: 3)
print(formatter.string(from: NSNumber(value: airfare4))!)

