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
    case enRoute //For flights currently travelling to or from destination/arrival
    case scheduled  //For future-dated flights that have not departed
    case canceled  //For flights that have been ground for x reasons
    case delayed  //Flights that have missed their initial departure time but still have plans of departing
    case landed  //Flights that have arrived to the destination/arrival terminal
    case onTime  //Flights that are set to leave at currently scheduled time but have not initiated flight yet
    case diverted  //Flights that have changed course of orignal flight plan due to x reason
}

struct Airport {
    let cityName: String
    let cityCode: String
}

struct Flight {
    let destination: Airport
    let airline: String
    let flightNumber: String
    let departureTime: Date?
    let terminal: String?
    let status: FlightStatus
}

class DepartureBoard {
    let flights: Flight
    
    init(flights: Flight) {
        self.flights = flights
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
let jfkDepartureBoard = DepartureBoard(flights: .init(destination: .init(cityName: "London",
                                                                         cityCode: "LHR"),
                                                                        airline: "Delta Airlines",
                                                                        flightNumber: "DL1",
                                                                        departureTime: Date(),
                                                                        terminal: "4",
                                                                        status: .scheduled))

let laxDepartureBoard = DepartureBoard(flights: .init(destination: .init(cityName: "Milan",
                                                                         cityCode: "MXP"),
                                                                         airline: "American Airlines",
                                                                         flightNumber: "AA198",
                                                                         departureTime: nil,
                                                                         terminal: nil,
                                                                         status: .canceled))

let atlDepartureBoard = DepartureBoard(flights: .init(destination: .init(cityName: "Las Vegas",
                                                                          cityCode: "LAS"),
                                                                           airline: "Virgin Atlantic",
                                                                           flightNumber: "VS4813",
                                                                           departureTime: Date(),
                                                                           terminal: "2",
                                                                           status: .onTime))

var depatureBoardArray = [jfkDepartureBoard, laxDepartureBoard, atlDepartureBoard]

print(jfkDepartureBoard.flights)
print(laxDepartureBoard.flights)
print(atlDepartureBoard.flights)
//: ## 3. Create a free-standing function that can print the flight information from the `DepartureBoard`
//: a. Use the function signature: `printDepartures(departureBoard:)`
//:
//: b. Use a `for in` loop to iterate over each departure
//:
//: c. Make your `FlightStatus` enum conform to `String` so you can print the `rawValue` String values from the `enum`. See the [enum documentation](https://docs.swift.org/swift-book/LanguageGuide/Enumerations.html).
//:
//: d. Print out the current DepartureBoard you created using the function
func printDepartures(departureBoard:) {
    for departures in depatureBoardArray{
        print(departures)
    }
}

printDepartures(jfkDepartureBoard)
printDepartures(depatureBoard: laxDepartureBoard)
printDepartures(depatureBoard: atlDepartureBoard)
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
func printDepartures2(departureBoard:) {
    if let date = Date,
        let terminal = terminal &&
            status == FlightStatus.canceled {
                print("")
    }
}


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
var checkedBags = 0
let costOfcheckedBags = 25
let mileCost = 0.10
var distance = 0
var travelers = 0

func calculateAirfare(checkedBags: Int, distance: Int, travelers: Int) -> Double {
    if travelers >= 0 &&
        distance >= 0 &&
        checkedBags >= 0 {
        let calculatedDistance = mileCost * Double(distance)
        let checkedBagfee = checkedBags * costOfcheckedBags
        let totalAirfare = Double(checkedBagfee) + Double(calculatedDistance) * Double(travelers)
        return totalAirfare
    } else {
        return 0
    }
}

calculateAirfare(checkedBags: 2, distance: 200, travelers: 2)
print(calculateAirfare(checkedBags: 2, distance: 200, travelers: 2))
