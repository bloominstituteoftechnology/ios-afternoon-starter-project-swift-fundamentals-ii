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
// Flight Status Enum
enum FlightStatus: String {
    case enRouteDelayed
    case enRouteOnTime
    case scheduled
    case canceled
    case delayed
    case landed
    case landedDelayed
    case landedOnTime
    case boarding
}

//Airport Struct
struct Airport {
    var destination: String
    //var arrival: time_value
}

//Flight Struct
struct Flight {
    var departureTime: Date?
    var terminal: String?
    
    var flightStatus: FlightStatus
    var destination: String
}

// Departure Board Class
class DepartureBoard {
    var departureFlights: [Flight]
    var currentAirport: Airport
    
    init(departureFlights: [Flight], currentAirport: Airport) {
        self.departureFlights = departureFlights
        self.currentAirport = currentAirport
    }
    
    
    // *** Exercice  5
    // Sending an alert to the passengers
    func sendAlertToPassangers() {
        
        // Setting up the Time and Date Styles
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .short
        // US English Locale (en_US)
        dateFormatter.locale = Locale(identifier: "en_US")
        
        
        //Itirating throght departureFlights
        for flight in departureFlights {
            
            var flightTime = "TBD"
            var flightTerminal = "TBD"
            
            // Safely unwrapping
            if flight.departureTime != nil {
                flightTime = dateFormatter.string(from: flight.departureTime!)
            }
            if flight.terminal != nil {
                flightTerminal = flight.terminal!
            }
            else {
                print("Unable to display Terminal information. Please see the nearest Information Desk for more details.")
            }
            
            
            // Switch to choose correct Alert
            switch flight.flightStatus {
                
            case .canceled:
                print("We're sorry your flight to \(flight.destination) was canceled, here is a $500 voucher")
            case .enRouteDelayed:
                print("Your flight to \(flight.destination) is in Route, but Delayed.")
            case .enRouteOnTime:
                print("Your flight to \(flight.destination) is in Route, and on time.")
            case .scheduled:
                print("Your flight to \(flight.destination) is scheduled to depart at \(flightTime) from terminal: \(flightTerminal).")
            case .delayed:
                print("We're sorry your flight to \(flight.destination) is delayed.")
            case .landed:
                print("Your flight to \(flight.destination) has landed.")
            case .landedDelayed:
                print("Your flight to \(flight.destination) has landed, but it's delayed.")
            case .landedOnTime:
                print("Your flight to \(flight.destination) has landed on time.")
            case .boarding:
                print("Your flight is boarding, please head to terminal: \(flightTerminal) immediately. The doors are closing soon.")
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

// Declaring the 3 Flights
var flight_B62611 = Flight(departureTime: Date(), terminal: "5", flightStatus: .canceled, destination: "Tokyo")
var flight_NH9 = Flight(departureTime: nil, terminal: "7", flightStatus: .enRouteOnTime, destination: "Atlanta")
var flight_MQ3957 = Flight(departureTime: Date(), terminal: "8", flightStatus: .landedDelayed, destination: "Toronto")

// Declaring an Airport
let lasVegas = Airport(destination: "Las Vegas")

// Declaring my Departure Board and appending the flights
let firstDepartureBoard = DepartureBoard(departureFlights: [], currentAirport: lasVegas)

firstDepartureBoard.departureFlights.append(flight_B62611)
firstDepartureBoard.departureFlights.append(flight_NH9)
firstDepartureBoard.departureFlights.append(flight_MQ3957)

// Changing properties from flights
flight_MQ3957.departureTime  = nil
flight_NH9.terminal = nil


//: ## 3. Create a free-standing function that can print the flight information from the `DepartureBoard`
//: a. Use the function signature: `printDepartures(departureBoard:)`
//:
//: b. Use a `for in` loop to iterate over each departure
//:
//: c. Make your `FlightStatus` enum conform to `String` so you can print the `rawValue` String values from the `enum`. See the [enum documentation](https://docs.swift.org/swift-book/LanguageGuide/Enumerations.html).
//:
//: d. Print out the current DepartureBoard you created using the function
// Free-standind function to print Departure Board information
func printDepartures(_ departureBoard: DepartureBoard) {
    print("\nDeparture Board from: \(departureBoard.currentAirport.destination)\n")
    
    for flight in departureBoard.departureFlights {
        
        print("Destination: \(flight.destination)\nTime: \(String(describing: flight.departureTime))\nStatus: \(flight.flightStatus.rawValue)\nTerminl: \(flight.terminal)\n")
    }
}

// Calling the function
printDepartures(firstDepartureBoard)

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

// Setting up the Time and Date Styles
let dateFormatter = DateFormatter()
dateFormatter.dateStyle = .none
dateFormatter.timeStyle = .short
// US English Locale (en_US)
dateFormatter.locale = Locale(identifier: "en_US")
//print(dateFormatter.string(from: date)) // Jan 2, 2001


//Second function to print Departure Board information
func printDeparture2(departureBoard: DepartureBoard) {
    print("\nDeparture Board from: \(departureBoard.currentAirport.destination)\n")
    
    for flight in departureBoard.departureFlights {
        
        // safely unwrapping
        if flight.departureTime != nil {
            
            print("Destination: \(flight.destination)\nTime: \(dateFormatter.string(from: flight.departureTime!))\nStatus: \(flight.flightStatus.rawValue)\nTerminl: \(flight.terminal)\n")
        }
        else {
            print("Destination: \(flight.destination)\nTime: \nStatus: \(flight.flightStatus.rawValue)\nTerminl: \(flight.terminal)\n")
        }
        
    }
}

//Calling the function
printDeparture2(departureBoard: firstDepartureBoard)

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
// I completed most of this exercice at the top of this file

// Calling the function
firstDepartureBoard.sendAlertToPassangers()



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
// Free-standind function to calculate Airfare
func calculateAirfare(checkedBags: Int, distance: Int, travelers: Int) -> Double {
    
    let bags = Double(checkedBags) * 25.0
    let miles = Double(distance) * 0.10
    let ticketPerPerson = bags + miles
    
    
    return ticketPerPerson * Double(travelers)
}


//Testing the fnction
print(calculateAirfare(checkedBags: 2, distance: 2_000, travelers: 3))
print(calculateAirfare(checkedBags: 1, distance: 3_000, travelers: 1))
print(calculateAirfare(checkedBags: 7, distance: 4_000, travelers: 4))
print(calculateAirfare(checkedBags: 7, distance: 4_000, travelers: 3))
