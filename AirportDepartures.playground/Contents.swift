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
/*1*/
/*1a.*/
enum FlightStatus {
    case enRouteDelayed =
    case scheduled
    case enRouteOnTime
    case canceled
    case landedOnTime
    case landedDelayed
}

/*1b.*/
//Am I meant to only have "Destination" and Arrival" variables here?
struct Airport {
    let city: String
    let abbreviation: String
}

/*1cde.*/
struct Flight {
    var destination: String
    var airline: String
    var flightNumber: String
    var depatureTime: Date?
    var terminal: String?
    var status: FlightStatus
    
}

/*1f*/

class DepartureBoard {
    var flights: [Flight]
    var airport: Airport
    
    init(city: String, abbreviation: String) { // We could name these variables anything, but we chose city and abbriviation.
        self.flights = [] //in the init, you are actually initializing instances of the properties.
        self.airport = Airport(city: city, abbreviation: abbreviation) // here we initalized a new instance of "airport." We didn't
    }
}

/* 2. Create 3 flights and add them to a departure board
a. For the departure time, use Date() for the current time  //Is that an Apple provided method or did we define it somewhere?
b. Use the Array append() method to add Flight’s
c. Make one of the flights .canceled with a nil departure time
d. Make one of the flights have a nil terminal because it has not been decided yet.
e. Stretch: Look at the API for DateComponents for creating a specific time */

var flight1 = Flight(destination: "LAX", airline: "Jet Blue", flightNumber: "G101", depatureTime: nil, terminal: nil, status: .canceled)
var flight2 = Flight(destination: "ONT", airline: "Delta", flightNumber: "B9", depatureTime: Date(), terminal: "8", status: .enRouteOnTime)
var flight3 = Flight(destination: "VIE", airline: "United Airlines", flightNumber: "F22", depatureTime: Date(), terminal: "5", status: .landedOnTime)

let departureBoard = DepartureBoard(city: "Los Angeles", abbreviation: "LAX")
//We create an instance of DepartureBoard in order to append to it.

departureBoard.flights.append(flight1)
departureBoard.flights.append(flight2)
departureBoard.flights.append(flight3)

/* 3. Create a free-Standing function that can print the flight information from the DepartureBoard
 a. Use the function signature: printDeparture(departureBoard:)
 b. Use a for in loop to iterate over each departure
 c. Make your FlightStatus enum conform to String so you can print the rawValue String values from the enum. see the enum documentation.
 d. Print out the current DepartureBoard you created using the funciton.*/

func printDeparture(departureBoard: DepartureBoard) {
    for departure in departureBoard.flights {
        print("\(departure.flights.rawValue)")
    }
}
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



