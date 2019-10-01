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
    case delayed
    case landed
    case scheduled
    case boarding
    case canceled
}

//  I wasn't sure what to do with the Airport struct. It didn't seem necessary for the way I implemented the code.

struct Airport {
    var isDeparture: Bool
    var name: String
}


// The Flight struct contains all of the necessary information and then the DepartureBoard is an array of all the flights
// Creating an instance of the DepartureBoard for each airport (in my code the example is the Austin, TX airport departures)

struct Flight {
    var airline: String
    var flightNum: String
    var departTime: Date?
    var terminal: String?
    var destination: String
    var status: FlightStatus
}

class DepartureBoard {
    var flights: [Flight]
    
    init() {
        self.flights = []
    }
    
    func alertpassengers() {
        for flight in flights {
            switch flight.status {
            case .boarding:
                print("Your flight is boarding, please head to terminal: \(flight.terminal ?? "TBD") immediately. The doors are closing soon.")
            case .canceled:
                print("We're sorry your flight to \(flight.destination) was canceled. Here is a $500 voucher.")
            case .delayed:
                print("Please be advised that flight \(flight.flightNum) is delayed.")
            case .enRoute:
                print("We hope you are enjoying your flight.")
            case .landed:
                print("We hope you enjoyed your flight.")
            case .scheduled:
                print("Flight \(flight.flightNum) to \(flight.destination) is on time.")
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

// I tried to find a use for the Airport struct but it was irrelevant

//var airportMSP = Airport(isDeparture: true, name: "Minneapolis/St. Paul")
//var airportORD = Airport(isDeparture: true, name: "Chicago OHare")
//var airportLGA = Airport(isDeparture: true, name: "NYC LaGuardia")
//var airportAUS = Airport(isDeparture: true, name: "Austin, TX")
//var airportLAS = Airport(isDeparture: true, name: "Las Vegas, NV")


var flightDL6555 = Flight(airline: "Delta", flightNum: "DL6555", departTime: Date(), terminal: "G16", destination: "Minneapolis, MN", status: .enRoute)
var flightAA433 = Flight(airline: "American", flightNum: "AA433", departTime: Date(), terminal: "C12", destination: "Chicago OHare", status: .delayed)
var flightUN8158 = Flight(airline: "United", flightNum: "UN8158", departTime: Date(), terminal: "A36", destination: "NYC LaGuardia", status: .scheduled)
var flightSW343 = Flight(airline: "Southwest", flightNum: "SW343", departTime: nil, terminal: "B1", destination: "Chicago OHare", status: .canceled)
var flightDL1167   = Flight(airline: "Delta", flightNum: "DL1167", departTime: Date(), terminal: nil, destination: "Las Vegas, NV", status: .scheduled)

var ausDepartureBoard = DepartureBoard()
ausDepartureBoard.flights.append(flightDL6555)
ausDepartureBoard.flights.append(flightAA433)
ausDepartureBoard.flights.append(flightUN8158)
ausDepartureBoard.flights.append(flightSW343)
ausDepartureBoard.flights.append(flightDL1167)




//: ## 3. Create a free-standing function that can print the flight information from the `DepartureBoard`
//: a. Use the function signature: `printDepartures(departureBoard:)`
//:
//: b. Use a `for in` loop to iterate over each departure
//:
//: c. Make your `FlightStatus` enum conform to `String` so you can print the `rawValue` String values from the `enum`. See the [enum documentation](https://docs.swift.org/swift-book/LanguageGuide/Enumerations.html).
//:
//: d. Print out the current DepartureBoard you created using the function

// function prints the board to the screen. Unwraps the two optionals, depart time and terminal and prints the board accordingly.

func printDepartures(departureBoard: DepartureBoard) {
    print("Destination\t\t\tAirline\t\tFlight\t\tTime\t\tGate\t\tStatus")
    for flight in departureBoard.flights {
        if let departureTime = flight.departTime {  // checks to see if departTime has a value
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "h:mm a"
            let time = dateFormatter.string(from: departureTime)
            
            if let gate = flight.terminal {       // checks to see if terminal has a value
                print("\(flight.destination)\t\t\(flight.airline)\t\t\(flight.flightNum)\t\t\(time)\t\t\(gate)\t\t\(flight.status.rawValue)")
            } else {
                print("\(flight.destination)\t\t\(flight.airline)\t\t\(flight.flightNum)\t\t\(time)\t\tNot Assigned\t\t\(flight.status.rawValue)")
            }
        } else {  // these are evaluated if there is no departTime value
            if let gate = flight.terminal {
                print("\(flight.destination)\t\t\(flight.airline)\t\t\(flight.flightNum)\t\tTBA\t\t\(gate)\t\t\(flight.status.rawValue)")
            } else {
                print("\(flight.destination)\t\t\(flight.airline)\t\t\(flight.flightNum)\t\tTBA\t\tNot Assigned\t\t\(flight.status.rawValue)")
            }
        }
    }
}

printDepartures(departureBoard: ausDepartureBoard)


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

ausDepartureBoard.alertpassengers()




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
func numberFormatter(amount: Double) -> String {
let formatter = NumberFormatter()
formatter.numberStyle = .currency
    return formatter.string(from: NSNumber(value: amount))!
}

func calculateAirfare(checkedBags: Int, distance: Int, travelers: Int) -> String {
    let bagPrice: Double = 25
    let milePrice: Double = 0.10
    
    let finalPrice = Double(checkedBags) * bagPrice + Double(travelers) * milePrice * Double(distance)
    return numberFormatter(amount: finalPrice)
}

let myCharge = calculateAirfare(checkedBags: 3, distance: 2500, travelers: 2)
print(myCharge)
