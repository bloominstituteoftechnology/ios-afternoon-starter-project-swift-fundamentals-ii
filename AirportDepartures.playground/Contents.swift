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
    case boarding
    case canceled
    case delayed
    case diverted
    case enRoute
    case landed
    case scheduled
}

struct Airport {
    let city: String
    let code: String
}

struct Flight {
    let destination: Airport
    let airline: String
    let flightNumber: String
    var departureTime: Date?
    let terminal: String?
    var status: FlightStatus
}

class DepartureBoard {
    var departureFlights: [Flight]
    var currentAirport: Airport

    init(currentAirport: Airport) {
        self.currentAirport = currentAirport
        self.departureFlights = []
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

let chicago = Airport(city: "Chicago", code: "ORD")
let portOfSpain = Airport(city: "Port of Spain", code: "POS")
let taipei = Airport(city: "Taipei", code: "TPE")

let flight1 = Flight(destination: chicago, airline: "Qatar Airways", flightNumber: "QR8185", departureTime: Date(), terminal: nil, status: .scheduled)
let flight2 = Flight(destination: portOfSpain, airline: "Caribbean Airlines", flightNumber: "BW551", departureTime: Date(), terminal: "4", status: .delayed)
let flight3 = Flight(destination: taipei, airline: "EVA Air", flightNumber: "BR31", departureTime: nil, terminal: "1", status: .canceled)

let seoul = Airport(city: "Seoul", code: "ICN")

let departureBoard = DepartureBoard(currentAirport: seoul)
departureBoard.departureFlights.append(contentsOf: [flight1, flight2, flight3])

//: ## 3. Create a free-standing function that can print the flight information from the `DepartureBoard`
//: a. Use the function signature: `printDepartures(departureBoard:)`
//:
//: b. Use a `for in` loop to iterate over each departure
//:
//: c. Make your `FlightStatus` enum conform to `String` so you can print the `rawValue` String values from the `enum`. See the [enum documentation](https://docs.swift.org/swift-book/LanguageGuide/Enumerations.html).
//:
//: d. Print out the current DepartureBoard you created using the function

func printDepartures(departureBoard: DepartureBoard) {
    for flight in departureBoard.departureFlights {
        var departureString: String = "---"
        if let departureTime = flight.departureTime {
            departureString = "\(departureTime)"
        }
        print("Destination: \(flight.destination.city) (\(flight.destination.code)), Airline: \(flight.airline), Flight: \(flight.flightNumber), Departure Time: \(departureString), Terminal: \(flight.terminal ?? ""), Status: \(flight.status)")
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

// I already unwrapped the optionals!


// with date formatting:
func printDepartures2(departureBoard: DepartureBoard) {
    for flight in departureBoard.departureFlights {
        var departureString: String = "---"
        if let departureTime = flight.departureTime {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .none
            dateFormatter.timeStyle = .short
            departureString = dateFormatter.string(from: departureTime)
        }


        print("Destination: \(flight.destination.city) (\(flight.destination.code)), Airline: \(flight.airline), Flight: \(flight.flightNumber), Departure Time: \(departureString), Terminal: \(flight.terminal ?? ""), Status: \(flight.status)")
    }
}

print("==============")
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

class DepartureBoard2 {
    var departureFlights: [Flight]
    var currentAirport: Airport

    init(currentAirport: Airport) {
        self.currentAirport = currentAirport
        self.departureFlights = []
    }

    func alertPassengers() {
        for flight in departureFlights {
            switch flight.status {
            case .canceled:
                print("We're sorry your flight to \(flight.destination.city) was canceled, here is a $500 voucher")
            case .scheduled:
                print("Your flight to \(flight.destination.city) is scheduled to depart at \(textString(from: flight.departureTime)) from terminal: \(flight.terminal ?? "TBD")")
            case .boarding:
                print("Your flight is boarding, please head to terminal: \(terminalMessage(flight.terminal)) immediately. The doors are closing soon.")

            case .delayed:
                print("Your flight to \(flight.destination.city) is delayed.")
            case .diverted:
                print("Your flight to \(flight.destination.city) has been diverted.")
            case .enRoute:
                print("Please enjoy your flight to \(flight.destination.city) on \(flight.airline)!")
            case .landed:
                print("Welcome to \(flight.destination.city). Thank you for flying \(flight.airline).")
            }
        }
    }

    func textString(from date: Date?) -> String {
        if let time = date {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .none
            dateFormatter.timeStyle = .short
            return dateFormatter.string(from: time)
        } else {
            return "TBD"
        }
    }

    func terminalMessage(_ terminal: String?) -> String {
        guard let terminal = terminal else {
            return "Please see the nearest information desk for more details."
        }
        return terminal
    }
}

print("==============")
let departureBoard2 = DepartureBoard2(currentAirport: seoul)
departureBoard2.departureFlights.append(contentsOf: [flight1, flight2, flight3])
departureBoard2.alertPassengers()

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
    var airfare: Double = 0
    airfare += Double(checkedBags * 25)
    airfare += Double(distance) * 0.10
    airfare *= Double(travelers)
    return airfare
}

print("==============")
print(calculateAirfare(checkedBags: 1, distance: 500, travelers: 1))
print(calculateAirfare(checkedBags: 2, distance: 800, travelers: 2))
print(calculateAirfare(checkedBags: 2, distance: 2000, travelers: 3))
