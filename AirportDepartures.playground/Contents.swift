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
    case onTime = "On Time"
    case enRoute = "En Route"
    case scheduled = "Scheduled"
    case canceled = "Cancelled"
    case delayed = "Delayed"
    
}

struct Airport {
    var departure: String
    var arrival: String
}

struct Flight {
    var flightNumber: String
    var airlines: String
    var departureTime: Date?
    var terminal: String?
    var flightStatus: FlightStatus
}

class DepartureBoard {
    var currentAirport: String
    var departureFlight: [Flight] = []
    
    init(currentAirport: String){
        self.currentAirport = currentAirport
    }
    func addFlights(flight: Flight) {
        departureFlight.append(flight)
    }
    func alertPassengers() {
        for flight in departureFlight {
            
//            let departureTimeString: String
//            if let departureID = flight.departureTime {
//                departureTimeString = String(departureID)
//            }
            
            
            let terminalID: String
            if let terminal = flight.terminal {
                terminalID = terminal
            }
            else { terminalID = "N/A" }
            
            
            switch flight.flightStatus {
                case .canceled:
                    print("We're sorry your flight was canceled, here is a $500 voucher")
                case .scheduled:
                        print("Your flight is scheduled to depart at the original time.")
                case .onTime:
                    print("Your flight is currently on time. Please go to terminal: \(terminalID)")
                case .enRoute:
                        print("Your flight is on the way!")
                case .delayed:
                        print("Your flight has been delayed, please see one of the airline staff so they can assist you.")
                default:
                    continue
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

let flight1 = Flight(flightNumber: "AF 2232", airlines: "Air France", departureTime: nil, terminal: "4", flightStatus: .canceled)
let flight2 = Flight(flightNumber: "AA 291", airlines: "American Airlines", departureTime: Date(), terminal: "8", flightStatus: .onTime)
let flight3 = Flight(flightNumber: "BA 4720", airlines: "British Airways", departureTime: Date(), terminal: nil, flightStatus: .delayed)


var flightBoard = DepartureBoard(currentAirport: "JFK")

flightBoard.addFlights(flight: flight1)
flightBoard.addFlights(flight: flight2)
flightBoard.addFlights(flight: flight3)


//: ## 3. Create a free-standing function that can print the flight information from the `DepartureBoard`
//: a. Use the function signature: `printDepartures(departureBoard:)`
//:
//: b. Use a `for in` loop to iterate over each departure
//:
//: c. Make your `FlightStatus` enum conform to `String` so you can print the `rawValue` String values from the `enum`. See the [enum documentation](https://docs.swift.org/swift-book/LanguageGuide/Enumerations.html).
//:
//: d. Print out the current DepartureBoard you created using the function

//func printDepartures(departureBoard: DepartureBoard ) {
//    for flights in departureBoard.departureFlight {
//        print("Flight Number: \(flights.flightNumber) , Airline: \(flights.airlines) , Departure Time: \(String(describing: flights.departureTime)) , Terminal: \(String(describing: flights.terminal)) , Flight Status: String(\(flights.flightStatus))")
//    }
//}
//
//printDepartures(departureBoard: flightBoard)



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
    for flights in departureBoard.departureFlight {
        
        if let terminal = flights.terminal , let time = flights.departureTime {
            print("Flight Number: \(flights.flightNumber) , Airline: \(flights.airlines) , Departure Time: \(String(describing: flights.departureTime))  , Terminal: \(String(describing: flights.terminal ?? "N/A")) , Flight Status: String(\(flights.flightStatus.rawValue))")
            } else if flights.terminal != nil {
            print("Flight Number: \(flights.flightNumber) , Airline: \(flights.airlines) , Departure Time: \(flights.departureTime ?? Date()) , Terminal: \(String(describing: flights.terminal ?? "N/A")) , Flight Status: \(flights.flightStatus.rawValue)")
        } else if flights.departureTime != nil {
            print("Flight Number: \(flights.flightNumber) , Airline: \(flights.airlines) , Departure Time: \(flights.departureTime ?? Date()) , Terminal: \(String(describing: flights.terminal ?? "N/A")) , Flight Status: \(flights.flightStatus.rawValue)")
        } else {
            print("Flight Number: \(flights.flightNumber) , Airline: \(flights.airlines) , Departure Time: \(flights.departureTime) , Terminal: \(String(describing: flights.terminal)) , Flight Status: \(flights.flightStatus.rawValue)")
            
        }
    }
}


//func printDepartures3(departureBoard: DepartureBoard) {
//    for flights in departureBoard.departureFlight {
//
//        if let
//
//
//    }
//}


printDepartures2(departureBoard: flightBoard)


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



flightBoard.alertPassengers()



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
        let bagCosts = Double(checkedBags) * 25
        let costOfmiles = Double(distance) * 0.10
        let ticketCost: Double = 200
        let travelersCost = Double(travelers) * ticketCost
        let totalAirFare = bagCosts + costOfmiles + travelersCost
        
        return totalAirFare
    }
    
    print(calculateAirfare(checkedBags: 2, distance: 200, travelers: 3))
    print(calculateAirfare(checkedBags: 4, distance: 300, travelers: 2))
    print(calculateAirfare(checkedBags: 6, distance: 10_000, travelers: 4))






