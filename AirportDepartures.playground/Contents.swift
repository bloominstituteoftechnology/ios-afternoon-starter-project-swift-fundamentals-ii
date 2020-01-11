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
    case EnRoute = "En Route"
    case Scheduled
    case Cancelled
    case Delayed
    case OnTime = "On Time"
    case Boarding
}

enum PlaneSize {
    case xLarge
    case large
    case medium
    case small
}

struct Airport {
    let name: String
    let location: String
    let numRunways: Int
    var allowedPlaneSizes: [PlaneSize] = [.xLarge, .large, .medium, .small] //needs to be mutable in order to provide 2 init methods since it has a default value
    
    func isPlaneAllowed(size planeSize: PlaneSize) -> Bool {
        for allowedSize in allowedPlaneSizes {
            if planeSize == allowedSize {
                return true
            }
        }
        return false
    }
}

struct Flight {
    let airline: String
    let callsign: String
    let departure: Airport
    let arrival: Airport
    let size: PlaneSize
    let numPassengers: Int
    var departureTime: Date? = nil
    var terminal: String? = nil
    var status: FlightStatus? = nil
    
    func canLandAtArrival() -> Bool {
        if arrival.isPlaneAllowed(size: size) {
            return true
        }
        return false
    }
    
    func formattedDate() -> String {
        var timeString = "TBD (See Information Desk)" //just in case something fails, we need to return something
        if let departureTime = self.departureTime {
           //format the time
           let dateFormatter = DateFormatter()
           dateFormatter.dateStyle = .none
           dateFormatter.timeStyle = .short
           let dateTime = dateFormatter.string(from: departureTime)
           timeString = dateTime
        }
        return timeString
    }
}

let buchField = Airport(name: "Buchanan Field", location: "Concord, CA", numRunways: 1, allowedPlaneSizes: [.medium, .small])
let jfkIntl = Airport(name: "JFK International", location: "New York, NY", numRunways: 4)

class DepartureBoard {
    var airport: Airport
    var flights: [Flight]
    
    init(airport: Airport) {
        self.flights = [Flight]()
        self.airport = airport
    }
    
    func addFlight(flight: Flight) {
        if flight.canLandAtArrival() {
            self.flights.append(flight)
        }
    }
    
    func departFlight(flight: Flight) {
        if let index = flights.firstIndex(where: { $0.callsign == flight.callsign }) {
            flights.remove(at: index)
        }
    }
    
    func sendStatusAlert() {
        //playSound("dingDong.wav")
        print("Announcements:")
        for flight in flights {
            if let status = flight.status { //only print flights that have a status
                //for handling a nil departure time
                var departureTimeMessage = ""
                if flight.departureTime != nil {
                    departureTimeMessage = "\(flight.formattedDate())"
                } else {
                    departureTimeMessage = "TBD (See Information Desk)"
                }
                //for handling a nil terminal
                var terminalMessage = ""
                if flight.terminal != nil {
                    terminalMessage = flight.terminal!
                } else {
                    terminalMessage = "TBD (See Information Desk)"
                }
                let destinationAirport = flight.arrival.name
                let callsign = flight.callsign
                    switch status {
                    case .Cancelled:
                        print("We're sorry your flight \(callsign) to \(destinationAirport) was cancelled, here is a $500 voucher.")
                    case .Scheduled:
                        print("Your flight \(callsign) to \(destinationAirport) is scheduled to depart at \(departureTimeMessage) from terminal: \(terminalMessage)")
                    case .Boarding:
                        print("Your flight \(callsign) to \(destinationAirport) is boarding, please head to terminal: \(terminalMessage) immediately. The doors are closing soon.")
                    case .Delayed:
                        print("We're sorry, but your flight \(callsign) to \(destinationAirport) has been delayed. Please head to Terminal: \(terminalMessage) to see your flight's new departure time.")
                    case .EnRoute:
                        print("Your flight \(callsign) to \(destinationAirport) is currently en route and is expected to arrive at Terminal \(terminalMessage) shortly. Departure time is scheduled for: \(departureTimeMessage)")
                    case .OnTime:
                        print("Your flight \(callsign) to \(destinationAirport) is on time. Please head to terminal \(terminalMessage) for your flight's departure at \(departureTimeMessage)")
                    }
            }
        }
        print()
    }
    
}

let departureBoard = DepartureBoard(airport: buchField)

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
var date = Date().addingTimeInterval(TimeInterval(5.0 * 60.0)) //add 5 minutes to the current time
let departingFlight = Flight(airline: "Private(Fred Sanders)", callsign: "JFK01", departure: buchField, arrival: jfkIntl, size: .small, numPassengers: 4, departureTime: date, terminal: "1", status: .OnTime)

date = date.addingTimeInterval(TimeInterval(115.0 * 60.0)) //2 hours from now since date is already set to 5 minutes from now
let arrivingFlight01 = Flight(airline: "Private(Montgomery Hewitt)", callsign: "Buch01", departure: jfkIntl, arrival: buchField, size: .medium, numPassengers: 12, departureTime: date, status: .Delayed)
let arrivingFlight02 = Flight(airline: "All Time Travel",callsign: "Buch02", departure: jfkIntl, arrival: buchField, size: .medium, numPassengers: 12)

departureBoard.addFlight(flight: departingFlight) //class method appends flight to flight array
departureBoard.addFlight(flight: arrivingFlight01)
departureBoard.addFlight(flight: arrivingFlight02)
//departureBoard.departFlight(flight: departingFlight) //uncommenting this will make it so there are no departing flights since there's only 1 instantiated
//: ## 3. Create a free-standing function that can print the flight information from the `DepartureBoard`
//: a. Use the function signature: `printDepartures(departureBoard:)`
//:
//: b. Use a `for in` loop to iterate over each departure
//:
//: c. Make your `FlightStatus` enum conform to `String` so you can print the `rawValue` String values from the `enum`. See the [enum documentation](https://docs.swift.org/swift-book/LanguageGuide/Enumerations.html).
//:
//: d. Print out the current DepartureBoard you created using the function
func listFlights(departing: Bool, departureBoard: DepartureBoard) {
    if departing {
        print("Departing Flights: ")
    } else {
        print("Arriving Flights: ")
    }
    for flight in departureBoard.flights {
        var printStatement = "Destination: \(flight.departure.name), Flight: \(flight.callsign), Airline: \(flight.airline)"
        if departing {
            if flight.departure.name == departureBoard.airport.name {
                if let terminal = flight.terminal {
                    printStatement += ", Terminal: \(terminal)"
                } else {
                    printStatement += "TBD (See Information Desk)"
                }
                if flight.departureTime != nil {
                    printStatement += ", Departure Time: \(flight.formattedDate())"
                } else {
                    printStatement += ", Departure Time: TBD (See Information Desk)"
                }
                if let status = flight.status {
                    printStatement += ", Status: \(status.rawValue)"
                }
                print(printStatement)
            }
        } else {
            if flight.departure.name != departureBoard.airport.name {
                var terminalStatement = "TBD (See Information Desk)"
                if let terminal = flight.terminal {
                    terminalStatement = terminal
                }
                printStatement += ", Terminal: \(terminalStatement)"
                
                var departureTime = "TBD (See Information Desk)"
                if flight.departureTime != nil { //no if let because variable would be unused
                    departureTime = "\(flight.formattedDate())"
                }
                printStatement += ", Departure Time: \(departureTime)"
                
                print(printStatement)
            }
            
        }
    }
    print()
}

listFlights(departing: false, departureBoard: departureBoard)
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
//modified previous function to include departing Bool
listFlights(departing: true, departureBoard: departureBoard)
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
departureBoard.sendStatusAlert()
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
    let bag = 25.0
    let mile = 0.1
    //convert parameter to Double, multiply by price
    let distancePrice = Double(distance) * mile
    let bagPrice = Double(checkedBags) * bag
    let totalPrice = (distancePrice + bagPrice) * Double(travelers) /*I did this because the test example came out to $750. But it should probably be total number of bags, not bags per passenger, meaning the format would look like: distancePrice * Double(travelers) + bagPrice
     */
    
    //format as USD
    let currencyFormatter = NumberFormatter()
    currencyFormatter.numberStyle = .currency
    currencyFormatter.currencySymbol = "$"
    if let prettyPrice = currencyFormatter.string(from: totalPrice as NSNumber) {
        print("Your total fare for \(travelers) passenger(s) with \(checkedBags) checked bag(s), travelling \(distance) miles comes to: \(prettyPrice)")
    }
    return totalPrice
}

calculateAirfare(checkedBags: 2, distance: 2000, travelers: 3) //test passes
calculateAirfare(checkedBags: 1, distance: 10, travelers: 3)
calculateAirfare(checkedBags: 8, distance: 1200, travelers: 2)
