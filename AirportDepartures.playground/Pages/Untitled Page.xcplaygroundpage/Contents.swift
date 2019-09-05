import UIKit

enum FlightStatus: String {
    case EnRoute = "En Route"
    case Scheduled = "Scheduled"
    case Canceled = "Canceled"
    case Delayed = "Delayed"
}

let enRoute = FlightStatus.EnRoute
let scheduled = FlightStatus.Scheduled
let canceled = FlightStatus.Canceled
let delayed = FlightStatus.Delayed

enum AirportTerminal {
    case Arrivals
    case Departures
}
let arrivals = AirportTerminal.Arrivals
let departures = AirportTerminal.Departures

struct Airport {
    let airportTerminal: AirportTerminal
    
}

struct Flights {
    var FlightStatus: FlightStatus
    var FlightTime: Date?
    var Terminal: String?
    
    
}
let flight01 = Flights(FlightStatus: .Canceled, FlightTime: nil, Terminal: "a1")
let flight02 = Flights(FlightStatus: .Delayed, FlightTime: Date(), Terminal: "b2")
let flight03 = Flights(FlightStatus: .EnRoute, FlightTime: Date(), Terminal: "g1")


class DepartureBoard {
    var departureFlights: [Flights]
    var currentAirport: String
    
    init (currentAirport: String = "JFK") {
        self.currentAirport = currentAirport
        departureFlights = []
    }
    func add(Flights: Flights) {
        departureFlights.append(Flights)
    }
    
    

    
    
}
func printDepartures(departureBoard:DepartureBoard) {
    for departures in departureBoard.departureFlights {
        var departureString: String = ""
        if let departureTime = departures.FlightTime{
            departureString = "\(departures.FlightTime)"
        }
        print(departures.FlightStatus)
        
    
    }
    
}
    let departure = DepartureBoard()
print("destination: \(departure.currentAirport), airline: \(departure.)")

printDepartures(departureBoard: departure)

// printDepartures(departureBoard: departure.departureFlights)


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




