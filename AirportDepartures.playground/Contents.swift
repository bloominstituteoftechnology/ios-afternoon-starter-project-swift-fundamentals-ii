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
    case EnRoute = "EnRoute"
    case Scheduled = "Scheduled"
    case Canceled = "Canceled"
    case Delayed = "Delayed"
    case Landed = "Landed"
    case Boarding = "Boarding"
}

struct Airport {
    var destination: String
}

struct Flight {
    var destination: String
    var airline: String
    var flight: String
    var departureTime: Date?
    var terminal: String?
    var status: FlightStatus
}


class DepartureBoard {
    var flightList: [Flight]
    var currentAirport: String
    
    init(flightList: [Flight], currentAirport: String) {
        self.flightList = flightList
        self.currentAirport = currentAirport
    }
    
    func alertPassengers() {
        for flight in flightList {
            // I think I have to nest another if let to handle departureTime optionals, as in Question 4's answer.
            if let terminal = flight.terminal {
                if let departureTime = flight.departureTime {
                switch flight.status {
                case .Canceled: print("We're sorry your flight to \(flight.destination) was canceled, here is a $500 voucher")
                case .Scheduled: print("Your flight to \(flight.destination) is scheduled to depart at \(departureTime) from terminal: \(terminal)")
                case .Boarding: print("Your flight is boarding, please head to terminal: \(terminal) immediately. The doors are closing soon.")
                case .Delayed: print("Your flight is delayed")
                case .EnRoute: print("Your flight to \(flight.destination) has departed")
                case .Landed: print("Your flight has landed")
                }
                } else {
                    switch flight.status {
                    case .Canceled: print("We're sorry your flight to \(flight.destination) was canceled, here is a $500 voucher")
                    case .Scheduled: print("Your flight to \(flight.destination) is scheduled to depart at TBD from terminal: \(terminal)")
                    case .Boarding: print("Your flight is boarding, please head to terminal: \(terminal) immediately. The doors are closing soon.")
                    case .Delayed: print("Your flight is delayed")
                    case .EnRoute: print("Your flight to \(flight.destination) has departed")
                    case .Landed: print("Your flight has landed")
                }
                }
            } else if let departureTime = flight.departureTime {
                switch flight.status {
                    case .Canceled: print("We're sorry your flight to \(flight.destination) was canceled, here is a $500 voucher")
                    case .Scheduled: print("Your flight to \(flight.destination) is scheduled to depart at \(departureTime) from terminal: TBD")
                    case .Boarding: print("Your flight is boarding, please head to terminal: TBD immediately. The doors are closing soon.")
                    case .Delayed: print("Your flight is delayed")
                    case .EnRoute: print("Your flight to \(flight.destination) has departed")
                    case .Landed: print("Your flight has landed")
                }
            } else {
                switch flight.status {
                case .Canceled: print("We're sorry your flight to \(flight.destination) was canceled, here is a $500 voucher")
                case .Scheduled: print("Your flight to \(flight.destination) is scheduled to depart at TBD from terminal: TBD")
                case .Boarding: print("Your flight is boarding, please head to terminal: TBD immediately. The doors are closing soon.")
                case .Delayed: print("Your flight is delayed")
                case .EnRoute: print("Your flight to \(flight.destination) has departed")
                case .Landed: print("Your flight has landed")
            }
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
var flight1 = Flight(destination: "Nantucket", airline: "Cape Air", flight: "9k 101", departureTime: Date(), terminal: "5", status: .EnRoute)
var flight2 = Flight(destination: "Rome", airline: "British Airways", flight: "B6 5921", departureTime: Date(), terminal: "8", status: .Landed)
var flight3 = Flight(destination: "Berlin", airline: "Aer Lingus", flight: "C7 3392",  departureTime: Date(), terminal: "10", status: .Scheduled)

var myJFKDepartureBoard = DepartureBoard(flightList: [], currentAirport: "JFK")

myJFKDepartureBoard.flightList.append(flight1)
myJFKDepartureBoard.flightList.append(flight2)
myJFKDepartureBoard.flightList.append(flight3)

flight1.departureTime = nil
flight2.terminal = nil





//: ## 3. Create a free-standing function that can print the flight information from the `DepartureBoard`
//: a. Use the function signature: `printDepartures(departureBoard:)`
//:
//: b. Use a `for in` loop to iterate over each departure
//:
//: c. Make your `FlightStatus` enum conform to `String` so you can print the `rawValue` String values from the `enum`. See the [enum documentation](https://docs.swift.org/swift-book/LanguageGuide/Enumerations.html).
//:
//: d. Print out the current DepartureBoard you created using the function
func printDepartures(departureBoard: DepartureBoard) {
    for flight in departureBoard.flightList {
        print(flight)
    }
}

printDepartures(departureBoard: myJFKDepartureBoard)


// not a pretty output like Question 4's example output
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
    for flight in departureBoard.flightList {
        if let departureTime = flight.departureTime {
            if let terminal = flight.terminal {
                print("Destination: \(flight.destination) Airline: \(flight.airline) Flight: \(flight.flight) Departure Time: \(departureTime) Terminal: \(terminal) Status: \(flight.status)")
            } else {
                print("Destination: \(flight.destination) Airline: \(flight.airline) Flight: \(flight.flight) Departure Time: \(departureTime) Terminal:  Status: \(flight.status)")
            }
        } else if let terminal = flight.terminal {
            print("Destination: \(flight.destination) Airline: \(flight.airline) Flight: \(flight.flight) Departure Time:  Terminal: \(terminal) Status: \(flight.status)")
        } else {
                print("Destination: \(flight.destination) Airline: \(flight.airline) Flight: \(flight.flight) Departure Time:  Terminal:  Status: \(flight.status)")
        }
    }
}

printDepartures2(departureBoard: myJFKDepartureBoard)


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
myJFKDepartureBoard.alertPassengers()



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
    let checkedBagCost: Int = 25
    let mileCost: Double = 0.10
    
    let totalBagCost = checkedBags * checkedBagCost
    let totalMileageCost = Double(distance) * mileCost
    let ticketCost = Double(totalBagCost) + totalMileageCost
    let totalCost = ticketCost * Double(travelers)
    
    return totalCost
}

calculateAirfare(checkedBags: 3, distance: 5000, travelers: 2)
calculateAirfare(checkedBags: 2, distance: 2000, travelers: 3)
calculateAirfare(checkedBags: 0, distance: 10000, travelers: 100)



