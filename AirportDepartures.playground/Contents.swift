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
enum FlightStatus: String{
    case Enroute = "En Route"
    case Canceled = "Canceled"
    case Delayed = "Delayed"
    case Landed = "Landed"
    case Boarding = "Boarding"
    case Scheduled = "Scheduled"
}

struct Airport{
    var name: String
    var location: String
}

struct Flight{
    var flightNumber: String
    var status: FlightStatus
    var departingAirport: Airport
    var departureTime: String? = DateFormatter.localizedString(from: Date(), dateStyle: .none, timeStyle: .short)
    var destinationAirport: Airport
    var terminal: String?
    var airline: String
    
}

class DepartureBoard{
    var flights: [Flight]
    var currentAirport: Airport
    
    init(currentAirport: Airport) {
        self.currentAirport = currentAirport
        self.flights = []
    }
    
    func addFlight(flight: Flight){
        flights.append(flight)

    }
    
    func alertPassengers(){
        for departures in flights{
            switch departures.status {
            case .Canceled:
                print("We're sorry your flight to \(departures.destinationAirport.name) was canceled, here is a $500 voucher")
            case .Scheduled:
                print("Your flight to \(departures.destinationAirport.name) is scheduled to depart at \(departures.departureTime ?? "TBD") from terminal: \(departures.terminal ?? "TBD")")
            case .Boarding:
                print("Your flight is boarding, please head to terminal: \(departures.terminal ?? "TBD") immediately. The doors are closing soon.")
            default:
                print("If you need assistance with your flight, find the nearest information desk.")
            }
        }
        print("\n")
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
let airport1 = Airport(name: "Minter Field", location: "Bakersfield")
let airport2 = Airport(name: "LAX", location: "Los Angeles")
let airport3 = Airport(name: "JFK", location: "Burbank")

let flight1 = Flight(flightNumber: "B6 01234", status: .Boarding, departingAirport: airport1, destinationAirport: airport2, terminal: "2", airline: "Cheap-O Flights")
let flight2 = Flight(flightNumber: "F2 54321", status: .Canceled, departingAirport: airport2, departureTime: nil, destinationAirport: airport3, terminal: "10", airline: "Hawaiian Air")
let flight3 = Flight(flightNumber: "R7 22334", status: .Scheduled, departingAirport: airport3, destinationAirport: airport1, terminal: nil, airline: "Luxury Above")


let myDepartureBoard = DepartureBoard(currentAirport: airport1)

myDepartureBoard.addFlight(flight: flight1)
myDepartureBoard.addFlight(flight: flight2)
myDepartureBoard.addFlight(flight: flight3)



//: ## 3. Create a free-standing function that can print the flight information from the `DepartureBoard`
//: a. Use the function signature: `printDepartures(departureBoard:)`
//:
//: b. Use a `for in` loop to iterate over each departure
//:
//: c. Make your `FlightStatus` enum conform to `String` so you can print the `rawValue` String values from the `enum`. See the [enum documentation](https://docs.swift.org/swift-book/LanguageGuide/Enumerations.html).
//:
//: d. Print out the current DepartureBoard you created using the function
func printDepartures(departureBoard: DepartureBoard){
    
    for departures in departureBoard.flights{
        print("Flight \(departures.flightNumber) leaving from \(departures.departingAirport.name) in \(departures.departingAirport.location) and headed to \(departures.destinationAirport.name) is currently \(departures.status.rawValue).")
    }
     print("\n")
}

printDepartures(departureBoard: myDepartureBoard)

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
func printDepartures2(departureBoard: DepartureBoard){
    
    for departure in departureBoard.flights{
        
    var stringDepartureTime: String = " "
    if let unknownDepartureTime = departure.departureTime{
            stringDepartureTime = "\(unknownDepartureTime)"
        }
        
    var stringTerminal: String = " "
    if let unknownTerminal = departure.terminal{
            stringTerminal = "\(unknownTerminal)"
        }
        
        print("Destination: \(departure.destinationAirport.name) Airline: \(departure.airline) Flight: \(departure.flightNumber) Departure Time: \(stringDepartureTime) Terminal: \(stringTerminal) Status: \(departure.status)")
    
    }
}

printDepartures2(departureBoard: myDepartureBoard)
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
myDepartureBoard.alertPassengers()



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


func calculateAirfare(checkedBags: Int, distance: Int, travelers: Int) -> Double{
    let costEachBag = (25 * checkedBags) * travelers
    let costPerMile = 0.10 * Double(distance)
    let airfareCost = (costPerMile * Double(travelers)) + Double(costEachBag)
    print(airfareCost)
    return(airfareCost)
}

calculateAirfare(checkedBags: 2, distance: 2000, travelers: 3)




//func calculateMileageReimbursement(miles: Int?, dollarPerMile: Double?) -> Double? {
//    guard let miles = miles, miles >= 0, let dollarPerMile = dollarPerMile, dollarPerMile >= 0 else{
//        return nil
//    }
//
//    let reimbursedMiles = Double(miles) * dollarPerMile
//    print("You drove \(miles) miles and the rate per mile is \(dollarPerMile). You will be reimbursed: \(reimbursedMiles)")
//    return reimbursedMiles
//}
//
//calculateMileageReimbursement(miles: 5, dollarPerMile: 10.50)
