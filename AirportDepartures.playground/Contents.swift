import UIKit

// by Marlon
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
    case enRoute = "En Route"
    case scheduled = "Scheduled"
    case canceled = "Canceled"
    case delayed = "Delayed"
}
    struct Airport {
    let destination: String
}

    struct Flight {
        let flightDestination: Airport
        let airline: String
        let flightNumber: String
        var departureTime: Date?
        var terminal: String?
        let flightStatus: FlightStatus
}

    class DepartureBoard {
        var name: String
        var currentAirport: String
        var departureFlight: [Flight]
        
    
        init(name: String, currentAirport: String, departureFlight: [Flight]) {
            self.name = name
            self.currentAirport = currentAirport
            self.departureFlight = departureFlight
            
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
    //Flight 1

    let flightStatus1: FlightStatus = .enRoute
    let flight1Airport = Airport(destination: "LAX")
    var flight1 = Flight(flightDestination: flight1Airport, airline: "American Airlines", flightNumber: "AA388", departureTime: Date(), terminal: "4", flightStatus: flightStatus1)
    var flightDeparture = DepartureBoard(name: "AA", currentAirport: "RDU", departureFlight: [flight1])
    //flight1departure.departureFlight.append(flight1)
   // print(flightDeparture.departureFlight)

    // Flight 2

    let flightStatus2: FlightStatus = .canceled
   let flight2Airport = Airport(destination: "JFK")
    var flight2 = Flight(flightDestination: flight2Airport, airline: "Delta Airlines", flightNumber: "D588", departureTime: nil, terminal: "9", flightStatus: flightStatus2)
   // var flight2departure = DepartureBoard(name: "Delta", currentAirport: "RDU", departureFlight: [flight2])
   flightDeparture.departureFlight.append(flight2)

    //Flight 3

    let flightStatus3: FlightStatus = .scheduled
      let flight3Airport = Airport(destination: "HNL")
    var flight3 = Flight(flightDestination: flight3Airport, airline: "Tokyo Airlines", flightNumber: "TA1122", departureTime: Date(), terminal: nil, flightStatus: flightStatus3)
      //var flight3departure = DepartureBoard(name: "Tokyo Airlines", currentAirport: "RDU", departureFlight: [flight3])
      flightDeparture.departureFlight.append(flight3)
      
    //print(flightDeparture.departureFlight)

//: ## 3. Create a free-standing function that can print the flight information from the `DepartureBoard`
//: a. Use the function signature: `printDepartures(departureBoard:)`
//:
//: b. Use a `for in` loop to iterate over each departure
//:
//: c. Make your `FlightStatus` enum conform to `String` so you can print the `rawValue` String values from the `enum`. See the [enum documentation](https://docs.swift.org/swift-book/LanguageGuide/Enumerations.html).
//:
//: d. Print out the current DepartureBoard you created using the function
 /* func printDepartures(departureBoard: DepartureBoard) {
    for departures in departureBoard.departureFlight {
        print(departures)
    }
}
printDepartures(departureBoard: flightDeparture) */

/* func printDepartures() {
    for departures in flightDeparture.departureFlight {
        print(departures)
    }
}
printDepartures() */

// c. Make your FlightStatus enum conform to String so you can print the rawValue String values from the enum. See the enum documentation.
//  let flightStatus1: FlightStatus = .enRoute
// let flightStatus2: FlightStatus = .canceled
// let flightStatus3: FlightStatus = .scheduled

 // print(flightStatus1.rawValue, flightStatus2.rawValue, flightStatus3.rawValue)

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
    if let unwrappedDepartureTime1 = flight1.departureTime {
             print(unwrappedDepartureTime1)
        }
        if let unwrappedDepartureTime2 = flight2.departureTime {
         print(unwrappedDepartureTime2)
     }
         if let unwrappedDepartureTime3 = flight3.departureTime {
             print(unwrappedDepartureTime3)
         }
         if let unwrappedTerminal1 = flight1.terminal {
             print(unwrappedTerminal1)
         }
         if let unwrappedTerminal2 = flight2.terminal {
             print(unwrappedTerminal2)
            }
         if let unwrappedTerminal3 = flight3.terminal {
             print(unwrappedTerminal3)
            }
    for departures in departureBoard.departureFlight {
        print(departures)
    }
 
}

printDepartures2(departureBoard: flightDeparture)
// i got it to unwrap but could not figure out how to insert the unwrapped value into the array

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
/*I tried to do problem 5 and creating this code messed up my other code that worked.
I had to go back to github and download my last git pushed document so that I didn't lose my mind and my work :-)
I think the way I set up my code has made this problem more difficult then it has to be. need help with this problem. Thanks.*/



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
        let costBags = Double(checkedBags) * 25.00
        let costDistance = Double(distance) * 0.10
        let totalCost = (costBags + costDistance) * Double(travelers)
        return totalCost
    }

    calculateAirfare(checkedBags: 2, distance: 2000, travelers: 3)

