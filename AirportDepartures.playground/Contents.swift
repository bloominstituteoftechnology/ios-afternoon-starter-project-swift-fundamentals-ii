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
let dateFormatter = DateFormatter()
dateFormatter.dateStyle = .none
dateFormatter.timeStyle = .short

// Created enumeration for FlightStatus

enum FlightStatus: String {
    case enRoute = "En Route"
    case scheduled = "Scheduled"
    case canceled = "Canceled"
    case delayed = "Delayed"
}

// Created Airport struct with name, city, state, and country

struct Airport {
    var name: String
    var city: String
    var state: String
    var country: String
}

// Created Flight struct with origin, destinationAirport, airline, flightNumber, departureTime, arrivalTime, terminalNumber, and status

struct Flight {
    var origin: Airport
    var destinationAirport: Airport
    var airline: String
    var flightNumber: String
    var departureTime: Date?
    var arrivalTime: String
    var terminalNumber: String?
    var status: FlightStatus
}

// Created Class DepartureBoard

class DepartureBoard {
    var departureFlights: [Flight]
    var currentAirport: Airport
    
    init(departureFlights: [Flight],
         currentAirport: Airport) {
        self.departureFlights = departureFlights
        self.currentAirport = currentAirport
    }
    
    func addFlight(flight: Flight) {
        self.departureFlights.append(flight)
        
    }
    
    func alertPassengers() {
        for flight in departureFlights{
            switch flight.status {
            case .enRoute:
                print("Flight number \(flight.flightNumber) is En Route and is scheduled to arrive \(flight.arrivalTime)")
            case .scheduled:
                if let unwrappedTime = flight.departureTime, let unwrappedTerminalNumber = flight.terminalNumber {
                print("Flight number \(flight.flightNumber) to \(flight.destinationAirport.city) is scheduled to depart at \(unwrappedTime) from terminal \(unwrappedTerminalNumber).")
                } else {
                    print("TBD")
                }
            case .canceled:
                if let unwrappedTerminalNumber = flight.terminalNumber {
                    print("Unfortunately, flight number \(flight.flightNumber) to \(flight.destinationAirport.city) at terminal number \(unwrappedTerminalNumber) was canceled. Here is a $500 voucher.")
                }

            case .delayed:
                print("Flight number \(flight.flightNumber) to \(flight.destinationAirport.city) has been delayed.")
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
// Created Three Airports

var jaxAirport = Airport(name: "JAX",
                         city: "Jacksonville",
                         state: "Florida",
                         country: "United States")

var phxAirport = Airport(name: "PHX",
                         city: "Phoenix",
                         state: "Arizona",
                         country: "United States")

var orlAirport = Airport(name: "ORL",
                         city: "Orlando",
                         state: "Florida",
                         country: "United States")

// Created Departure Board

var departureBoard = DepartureBoard(departureFlights: [], currentAirport: phxAirport)

// Creating Three Flights

var flightOne = Flight(origin: phxAirport,
                       destinationAirport: jaxAirport,
                       airline: "American Airline",
                       flightNumber: "V289",
                       departureTime: Date(),
                       arrivalTime: "10:00PM",
                       terminalNumber: "34",
                       status: .delayed)

var flightTwo = Flight(origin: jaxAirport,
                       destinationAirport: phxAirport,
                       airline: "Delta",
                       flightNumber: "X372",
                       departureTime: Date(),
                       arrivalTime: "11:30PM",
                       terminalNumber: "42",
                       status: .scheduled)

var flightThree = Flight(origin: orlAirport,
                         destinationAirport: jaxAirport,
                         airline: "American Airline",
                         flightNumber: "L891",
                         departureTime: nil,
                         arrivalTime: "9:00AM",
                         terminalNumber: nil,
                         status: .canceled)

var flightFour = Flight(origin: orlAirport,
                         destinationAirport: phxAirport,
                         airline: "Southwest Airlines",
                         flightNumber: "D131",
                         departureTime: Date(),
                         arrivalTime: "8:15PM",
                         terminalNumber: "21",
                         status: .enRoute)

// Appending Three Flights To Departure Board

departureBoard.addFlight(flight: flightOne)
departureBoard.addFlight(flight: flightTwo)
departureBoard.addFlight(flight: flightThree)
departureBoard.addFlight(flight: flightFour)
//: ## 3. Create a free-standing function that can print the flight information from the `DepartureBoard`
//: a. Use the function signature: `printDepartures(departureBoard:)`
//:
//: b. Use a `for in` loop to iterate over each departure
//:
//: c. Make your `FlightStatus` enum conform to `String` so you can print the `rawValue` String values from the `enum`. See the [enum documentation](https://docs.swift.org/swift-book/LanguageGuide/Enumerations.html).
//:
//: d. Print out the current DepartureBoard you created using the function
func printDepartures(a: DepartureBoard) {
    
    print("Welcome To \(a.currentAirport.city)'s Airport!\n")
    
    for flight in a.departureFlights {
        
        print("Destination: \(flight.destinationAirport.city)")
        print("Flight Status: \(flight.status.rawValue)")
        print("Flight Number: \(flight.flightNumber)")
        
        if let unwrappedTerminalNumber = flight.terminalNumber {
            print("Terminal: \(unwrappedTerminalNumber)")
        }
        
        if let unwrappedDepartureTime = flight.departureTime {
            print("Departure Time: \(unwrappedDepartureTime)\n")
        }
    }
}

printDepartures(a: departureBoard)
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
func printDepartures2(a: DepartureBoard) {
    
    print("Welcome To \(a.currentAirport.city)'s Airport!\nThere are \(a.departureFlights.count) total flights today.\n")
    
    for flight in a.departureFlights {
        
        print("Destination: \(flight.destinationAirport.city)")
        print("Airline: \(flight.airline)")
        print("Flight: \(flight.flightNumber)")
        if let unwrappedDepartureTime = flight.departureTime {
            print("Departure Time: \(unwrappedDepartureTime)")
        }
    
        if let unwrappedTerminalNumber = flight.terminalNumber {
            print("Terminal: \(unwrappedTerminalNumber)")
        } else {
            print("Terminal: No Terminal Has Been Assigned Yet")
        }
        if flight.status != .canceled {
        print("Status: \(flight.status.rawValue)\n")
        } else {
            print("Flight Canceled\n")
        }

    }
    
}

printDepartures2(a: departureBoard)
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
func calculateAirfare(checkedBags: Double, distance: Double, travelers: Double) -> Double {
    let checkedBagsTotal = checkedBags * 25
    let distanceTotal = distance * 0.10
    let distanceAndCheckedBags = checkedBagsTotal + distanceTotal
    let finalTotal = distanceAndCheckedBags * travelers
    print("Your total price is: $\(finalTotal)")
    return finalTotal
}

calculateAirfare(checkedBags: 2, distance: 2000, travelers: 3)
