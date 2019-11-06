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
    case enRoute_OnTime = "En Route - On-time"
    case enRoute_Delayed = "En Route - Delayed"
    case landed_OnTime = "Landed - On-time"
    case landed_Delayed = "Landed - Delayed"
    case scheduled_OnTime = "Scheduled - On-time"
    case scheduled_Delayed = "Scheduled - Delayed"
    case canceled = "Canceled"
}

struct Airport {
    let city: String
    let IATACode: String
}

struct Flight {
    var destination: Airport
    var airline: String
    var flightNumber: String
    var departureTime: Date?
    var terminal: String?
    var status: FlightStatus
}

class DepartureBoard {
    let currentAirport: Airport
    var departures: [Flight]
    
    init(currentAirport: Airport, departures: [Flight] = []) {
        self.currentAirport = currentAirport
        self.departures = departures
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
let JFKAirport = Airport(city: "New York", IATACode: "JFK")
let LAXAirport = Airport(city: "Los Angeles", IATACode: "LAX")
var departureBoard = DepartureBoard(currentAirport: JFKAirport)

let flight1 = Flight(destination: LAXAirport,
                     airline: "Qantas",
                     flightNumber: "QF 12",
                     departureTime: Date(),
                     terminal: "8",
                     status: .enRoute_OnTime)

let flight2 = Flight(destination: Airport(city: "Ontario", IATACode: "ONT"),
                     airline: "JetBlue Airways",
                     flightNumber: "B6 355",
                     departureTime: Calendar.current.date(from: DateComponents(year: 2019, month: 11, day: 5, hour: 18, minute: 0)),
                     terminal: nil,
                     status: .scheduled_Delayed)

let flight3 = Flight(destination: LAXAirport,
                     airline: "Delta Air Lines",
                     flightNumber: "DL 477",
                     departureTime: nil,
                     terminal: "4",
                     status: .canceled)

departureBoard.departures.append(flight1)
departureBoard.departures.append(flight2)
departureBoard.departures.append(flight3)
//: ## 3. Create a free-standing function that can print the flight information from the `DepartureBoard`
//: a. Use the function signature: `printDepartures(departureBoard:)`
//:
//: b. Use a `for in` loop to iterate over each departure
//:
//: c. Make your `FlightStatus` enum conform to `String` so you can print the `rawValue` String values from the `enum`. See the [enum documentation](https://docs.swift.org/swift-book/LanguageGuide/Enumerations.html).
//:
//: d. Print out the current DepartureBoard you created using the function
func printDepartures(departureBoard: DepartureBoard) {
    // specify the width (number of characters) of each column in the Departure Board
    let COLUMN_WIDTH = [22, 20, 12, 14, 12, 20]
    
    // specify the format of the departure time on the Departure Board
    let dateFormatter = DateFormatter()
    dateFormatter.timeStyle = .short // h:mm AM/PM
    
    let departureBoardHeader =
        "Destination" + String.init(repeating: " ", count: (COLUMN_WIDTH[0] - "Destination".count)) +
            "Airline" + String.init(repeating: " ", count: (COLUMN_WIDTH[1] - "Airline".count)) +
            "Flight" + String.init(repeating: " ", count: (COLUMN_WIDTH[2] - "Flight".count)) +
            "Departure" + String.init(repeating: " ", count: (COLUMN_WIDTH[3] - "Departure".count)) +
            "Terminal" + String.init(repeating: " ", count: (COLUMN_WIDTH[4] - "Terminal".count)) +
            "Status" + String.init(repeating: " ", count: (COLUMN_WIDTH[5] - "Status".count))
    
    print("\(departureBoardHeader)\n")
    
    for flight in departureBoard.departures {
        let destination = flight.destination.city + " (" + flight.destination.IATACode + ")"
        let airline = flight.airline
        let flightNumber = flight.flightNumber
        
        var departureTime = ""
        if let date = flight.departureTime {
            departureTime = dateFormatter.string(from: date)
        }
        
        let terminal = flight.terminal ?? ""
        let status = flight.status.rawValue
        
        // Creates a single String containing all of the flight information to be displayed on one row and strategically adds spaces to align the data into columns
        let departureBoardRow =
            destination + String.init(repeating: " ", count: (COLUMN_WIDTH[0] - destination.count)) +
                airline + String.init(repeating: " ", count: (COLUMN_WIDTH[1] - airline.count)) +
                flightNumber + String.init(repeating: " ", count: (COLUMN_WIDTH[2] - flightNumber.count)) +
                departureTime + String.init(repeating: " ", count: (COLUMN_WIDTH[3] - departureTime.count)) +
                terminal + String.init(repeating: " ", count: (COLUMN_WIDTH[4] - terminal.count)) +
                status + String.init(repeating: " ", count: (COLUMN_WIDTH[5] - status.count))
                
        print(departureBoardRow)
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
// printDepartures2(departureBoard:) is a simplified version of the original printDepartures(departureBoard:) function in Step 3.
// This function is designed to print the departure board information as shown in the above example.
print()
func printDepartures2(departureBoard: DepartureBoard) {
    let dateFormatter = DateFormatter()
    dateFormatter.timeStyle = .short // h:mm AM/PM
    
    for flight in departureBoard.departures {
        let destination = flight.destination.city + " (" + flight.destination.IATACode + ")"
        let airline = flight.airline
        let flightNumber = flight.flightNumber
        
        var departureTime = ""
        if let date = flight.departureTime {
            departureTime = dateFormatter.string(from: date)
        }
        
        let terminal = flight.terminal ?? ""
        let status = flight.status.rawValue
        
        let departureBoardRow = "Destination: \(destination), Airline: \(airline), Flight: \(flightNumber), Departure: \(departureTime), Terminal: \(terminal), Status: \(status)"
                
        print(departureBoardRow)
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



