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
    case enRoute
    case scheduled
    case cancelled
    case delayed
}

struct Airport {
    let name: String
    let address: String
    let phoneNumber: String
    let gates: String
    let numberOfEmployees: Int
    let numberOfPlanes: Int
}

struct Flight {
    let craftName: String
    let terminal: String?
    let passangerNumber: String
    let isCheckedIn: Bool
    let seatNumber: String
    let departureTime: Date?
    let status: FlightStatus
}

class DepartureBoard {
    var flights: [Flight]
    var currentAirport: Airport
    
    init(currentAirport: Airport) {
        flights = []
        self.currentAirport = currentAirport
    }
    
    func alertPassengers() {
        var departureTime: String
        var terminal: String
        
        for flight in flights {
            if let departTime = flight.departureTime {
                let formatter = DateFormatter()
                formatter.dateFormat = "MM-dd-yyyy HH:mm:ss"
                formatter.dateStyle = .short
                formatter.timeStyle = .short
                let dateString = formatter.string(from: departTime)
                departureTime = dateString
            } else {
                departureTime = "TBD"
            }
            if let term = flight.terminal {
                terminal = term
            } else {
                terminal = "TBD"
            }
           
            switch flight.status {
            case .enRoute:
                print("Your flight is boarding, please head to terminal: \(terminal) immediately. The doors are closing soon.")
            case .delayed:
                print("We are sorry but your flight is delayed at this time.")
            case .cancelled:
                print("We're sorry your flight was canceled, here is a $500 voucher")
            case .scheduled:
                print("Your flight is scheduled to depart at \(departureTime) from terminal: \(terminal)")
            
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
let flight1 = Flight(craftName: "Boing 777", terminal: "A", passangerNumber: "E8798", isCheckedIn: true, seatNumber: "B3", departureTime: nil, status: .cancelled)

let flight2 = Flight(craftName: "Boing 222", terminal: nil, passangerNumber: "R456", isCheckedIn: true, seatNumber: "D17", departureTime: Date(), status: .enRoute)

let flight3 = Flight(craftName: "Boing 345", terminal: "C", passangerNumber: "FR55", isCheckedIn: true, seatNumber: "F33", departureTime: DateComponents(year: 1985, month: 10, day: 25, hour: 8, minute: 00, second: 00).date, status: .scheduled)

let bangorAirport = Airport(name: "Bangor Airport", address: "12 street, Bangor ME, 04041", phoneNumber: "207-485-8899", gates: "12", numberOfEmployees: 12_099, numberOfPlanes: 2_000)

let departureBoard = DepartureBoard(currentAirport: bangorAirport)
departureBoard.flights.append(flight1)
departureBoard.flights.append(flight2)
departureBoard.flights.append(flight3)

//: ## 3. Create a free-standing function that can print the flight information from the `DepartureBoard`
//: a. Use the function signature: `printDepartures(departureBoard:)`
//:
//: b. Use a `for in` loop to iterate over each departure
//:
//: c. Make your `FlightStatus` enum conform to `String` so you can print the `rawValue` String values from the `enum`. See the [enum documentation](https://docs.swift.org/swift-book/LanguageGuide/Enumerations.html).
//:
//: d. Print out the current DepartureBoard you created using the function
func printDepartures(departureBoard: DepartureBoard) {
    for departure in departureBoard.flights {
        print(departure)
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
/*
let craftName: String
let terminal: String?
let passangerNumber: String
let isCheckedIn: Bool
let seatNumber: String
let departureTime: Date?
let status: FlightStatus
*/
func printDepartures2(departureBoard: DepartureBoard) {
    var terminalValue: String
    var departureDate: String
    for departures in departureBoard.flights {
        if let terminal = departures.terminal {
            terminalValue = terminal
        } else {
            terminalValue = ""
        }
        
        if let departureTime = departures.departureTime {
            
                    let formatter = DateFormatter()
                    formatter.dateFormat = "MM-dd-yyyy HH:mm:ss"
                    formatter.dateStyle = .short
                    formatter.timeStyle = .short
                    let dateString = formatter.string(from: departureTime)
        
            departureDate = dateString
        } else {
            departureDate = ""
        }
        
        print("Craft Name: \(departures.craftName), terminal: \(terminalValue), passenger number: \(departures.passangerNumber) Are you checked In?:\(departures.isCheckedIn), seat #: \(departures.seatNumber), departure Time: \(departureDate), flight status: \(departures.status.rawValue)")
    }
}

printDepartures2(departureBoard: departureBoard)
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

departureBoard.alertPassengers()


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
    
    var totalAmount: Double = 0
    
    totalAmount += Double(checkedBags * 25)
    totalAmount += Double(distance) * 0.1
    totalAmount *= Double(travelers)
    
    return totalAmount
}

let numberFormatter = NumberFormatter()
numberFormatter.numberStyle = .currency

if let amountInDollars = numberFormatter.string(from: calculateAirfare(checkedBags: 5, distance: 25000, travelers: 39) as NSNumber) {
    print(amountInDollars)
}

