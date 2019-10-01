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
// NOTE: 'TODO' comments marked w/ "(ideally)" aren't intended to be completed in this project, but are some ideas of how to improve this sort of thing in the real world

// helper functions & vars
//-------------------
// set JFK calendar for date formatting
var jfkCalendar = Calendar.current
if let timeZone = TimeZone(abbreviation: "EST") {
    jfkCalendar.timeZone = timeZone
}

let jfkDateFormatter = DateFormatter()
jfkDateFormatter.dateStyle = .none
jfkDateFormatter.timeStyle = .short
jfkDateFormatter.timeZone = jfkCalendar.timeZone

// Types

enum FlightStatus: String {
    case scheduledOnTime = "Scheduled -- On Time"
    case scheduledDelayed = "Scheduled -- Delayed"
    case landedOnTime = "Landed -- On Time"
    case landedDelayed = "Landed -- Delayed"
    case boarding = "Boarding"
    case canceled = "Canceled"
    case enRouteOnTime = "En Route -- On Time"
    case enRouteDelayed = "En Route -- Delayed"
}

struct Airport {
    var name: String
    var id: String
    var location: String
}

struct Flight {
    let id: String
    let airline: String // TODO: make another class for airlines (ideally)
    let origin: Airport
    let destination: Airport
    var status: FlightStatus = .scheduledOnTime
    private (set) var departureTime: Date?
    private (set) var arrivalTime: Date?
    private (set) var duration: TimeInterval?
    var terminal: String? = nil
    
    init(id: String, airline: String, origin: Airport, destination: Airport, departureTime: Date, duration: TimeInterval, terminal: String? = nil) {
        self.id = id // TODO: get flight ID num programmatically to avoid human error (ideally)
        self.airline = airline
        self.origin = origin
        self.destination = destination
        self.departureTime = departureTime
        self.duration = duration // TODO: somehow get duration programmatically (ideally)
        self.arrivalTime = Date(timeInterval: duration, since: departureTime)
        self.terminal = terminal
    }
    
    // below methods allow adjusting times (including to 'nil' times)
    mutating func changeDepartureTime(to time: Date?) {
        self.departureTime = time
        if let duration = self.duration, let time = time {
            self.arrivalTime = Date(timeInterval: duration, since: time)
        }
    }
    
    mutating func changeArrivalTime(to time: Date?) {
        self.arrivalTime = time
        if let duration = self.duration, let time = time {
            self.departureTime = Date(timeInterval: -duration, since: time)
        }
    }
    
    // (commented out because not actually needed)
    //mutating func changeDuration(to duration: TimeInterval) {
    //    self.duration = duration
    //    if let departureTime = self.departureTime {
    //        self.arrivalTime = Date(timeInterval: duration, since: departureTime)
    //    }
    //}
    
    mutating func cancel() {
        self.departureTime = nil
        self.arrivalTime = nil
        self.duration = nil
        self.terminal = nil
        self.status = .canceled
        // TODO: automatically notify passengers of cancellation (ideally)
    }
}

class DepartureBoard {
    let currentAirport: Airport
    var flights: [Flight] = []
    
    init(_ airport: Airport) {
        self.currentAirport = airport
    }
    
    func alertPassengers() {
        for flight in flights {
            let depTimeText: String
            if let departureTime = flight.departureTime {
                depTimeText = jfkDateFormatter.string(from: departureTime)
            } else {
                depTimeText = "TBD"
            }
            
            let termText: String
            if let terminal = flight.terminal {
                termText = terminal
            } else {
                termText = "TBD"
            }
            
            var alertText = ""
            
            // NOTE: I know there are instances where some cases are handled in two spots; that is to concatenate the alert text with the proper message(s).
            switch flight.status {
            case .canceled:
                alertText += "We're sorry your flight to \(flight.destination.location) was canceled. A $500 voucher is available for the inconvenience."
            case .scheduledDelayed, .landedDelayed, .enRouteDelayed:
                alertText += "We're sorry, but your flight has been delayed. "
                fallthrough
            case .scheduledOnTime, .scheduledDelayed, .enRouteDelayed, .enRouteOnTime, .landedOnTime, .landedDelayed:
                alertText += "Your flight to \(flight.destination.location) is scheduled to depart at \(depTimeText) from Terminal \(termText)."
                fallthrough
            case .landedDelayed, .landedOnTime:
                alertText += " It has currently landed."
            case .boarding:
                alertText += "Your flight is boarding. Please head to Terminal \(termText) immediately. The doors are closing soon."
            }
            if flight.terminal == nil {
                alertText += " Please see the information desk for more details."
            }
            print(alertText)
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

// set flight dates
func dateFromComponents(year: Int, month: Int, day: Int, hour: Int, minute: Int) -> Date {
    let dateComponents = DateComponents(calendar: jfkCalendar, year: year, month: month, day: day, hour: hour, minute: minute)
    
    let date: Date
    if let realDate = dateComponents.date {
        date = realDate
    } else {
        date = Date()
        print("Invalid date! Returning current date/time.")
    }
    
    return date
}
//------------------

// initialize airports, departure board, flight dates
let jfk = Airport(name: "John F. Kennedy International Airport", id: "JFK", location: "New York, NY")
let sea = Airport(name: "Seattle-Tacoma International Airport", id: "SEA", location: "SeaTac, WA")
let bli = Airport(name: "Bellingham International Airport", id: "BLI", location: "Bellingham, WA")

let frontDepartureBoard = DepartureBoard(jfk)

let flight1Date = dateFromComponents(year: 2019, month: 10, day: 1, hour: 18, minute: 30)
let flight3Date = dateFromComponents(year: 2019, month: 10, day: 1, hour: 8, minute: 55)

// initialize flights
var flightDL2563 = Flight(id: "DL 2563",
                     airline: "Delta Air Lines",
                     origin: jfk,
                     destination: sea,
                     departureTime: flight1Date,
                     duration: TimeInterval(18000),
                     terminal: "1")

var flightVS3941 = Flight(id: "VS 3941",
                     airline: "Virgin Atlantic",
                     origin: jfk,
                     destination: sea,
                     departureTime: Date(),
                     duration: TimeInterval(19000),
                     terminal: "2")
flightVS3941.cancel()

var flightB61592 = Flight(id: "B6 1592",
                     airline: "JetBlue Airways",
                     origin: jfk,
                     destination: bli,
                     departureTime: flight3Date,
                     duration: TimeInterval(20000))

var flightB61788 = Flight(id: "B6 1788",
                          airline: "JetBlue Airways",
                          origin: jfk,
                          destination: bli,
                          departureTime: Date(),
                          duration: TimeInterval(20000),
                          terminal: "4")
flightB61788.status = .boarding

frontDepartureBoard.flights.append(flightDL2563)
frontDepartureBoard.flights.append(flightVS3941)
frontDepartureBoard.flights.append(flightB61592)
frontDepartureBoard.flights.append(flightB61788)

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
        print("Flight : \(flight.id)")
        print("\tDestination: \(flight.destination.location) (\(flight.destination.id))")
        print("\tAirline    : \(flight.airline)")
        
        var departureDisplayText = "\tDeparts    : "
        if let departureTime = flight.departureTime {
            departureDisplayText += jfkDateFormatter.string(from: departureTime)
        } else {
            departureDisplayText += "n/a"
        }
        print(departureDisplayText)
        
        var terminalDisplayText = "\tTerminal   : "
        if let terminal = flight.terminal {
            terminalDisplayText += "\(terminal)"
        } else {
            terminalDisplayText += "n/a"
        }
        print(terminalDisplayText)
        
        print("\tStatus     : \(flight.status.rawValue)")
    }
}

printDepartures(departureBoard: frontDepartureBoard)

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

// see above

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
// see above (part 1) for method definition

frontDepartureBoard.alertPassengers()
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

func formatDollarsAsString(cost: Double) -> String? {
    let dollarFormatter = NumberFormatter()
    dollarFormatter.usesGroupingSeparator = true
    dollarFormatter.numberStyle = .currency
    dollarFormatter.currencySymbol = "$"
    
    return dollarFormatter.string(from: NSNumber(value: cost))
}

func calculateAirfare(checkedBags: Int, distance: Int, travelers: Int) -> Double {
    let costPerBag: Double = 25
    let costPerMile: Double = 0.1
    
    let bagCost: Double = Double(checkedBags) * costPerBag
    let costPerTicket: Double = Double(distance) * costPerMile
    let ticketSubtotal: Double = costPerTicket * Double(travelers)
    
    let totalCost: Double = bagCost + ticketSubtotal
    
    if let costString = formatDollarsAsString(cost: totalCost) {
        print("Total airfare: \(costString)")
    }
    
    return totalCost
}

calculateAirfare(checkedBags: 2, distance: 2000, travelers: 3)
calculateAirfare(checkedBags: 1, distance: 0, travelers: 20)
calculateAirfare(checkedBags: 0, distance: 100, travelers: 1)
calculateAirfare(checkedBags: 4, distance: 14_999, travelers: 1)
