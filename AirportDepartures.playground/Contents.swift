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
//1a. Use an enum type for the FlightStatus (En Route, Scheduled, Canceled, Delayed, etc.)
//3c. Make your FlightStatus enum conform to String so you can print the rawValue String values from the enum.
enum FlightStatus: String{
    case EnRoute
    case Scheduled
    case Canceled
    case Delayed
    //c. If their flight is boarding print out:...
    case Boarding
}
//1b. Use a struct to represent an Airport (Destination or Arrival)
struct Airport{
    let destination: String
    let arrival: String
}
//1c. Use a struct to represent a Flight.
struct Flight{
    let destination: String
    let airLine: String
    let flight: String
    //1d. Use a Date? for the departure time since it may be canceled.
    let departureDate: Date?
    //1e. Use a String? for the Terminal, since it may not be set yet (i.e.: waiting to arrive on time)
    let terminal: String?
    let flightStatus: FlightStatus
}
//1f. Use a class to represent a DepartureBoard with a list of departure flights, and the current airport
class DepartureBoard{
    var flightList: [Flight]
    let currentAirport: String
    func test(flightList: [Flight]){
        for flight in flightList{
            print(flight.airLine)
        }
    }
    
    init(flightList:[Flight],currentAirport:String){
        self.flightList = flightList
        self.currentAirport = currentAirport
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
//2a. For the departure time, use Date() for the current time
//2c. Make one of the flights .canceled with a nil departure time
//2d. Make one of the flights have a nil terminal because it has not been decided yet.
//2e. Stretch: Look at the API for DateComponents for creating a specific time
let flight1 = Flight(destination: "San Francisco", airLine: "United Airlines", flight: "9K 101", departureDate: Date(timeIntervalSince1970: 1574215200), terminal: nil, flightStatus: .Scheduled)
let flight2 = Flight(destination: "New York City", airLine: "Delta", flight: "4A 121", departureDate: Date(timeIntervalSince1970: 1574218800), terminal: "4", flightStatus: .Scheduled)
let flight3 = Flight(destination: "New Orleans", airLine: "Jet Blue", flight: "4A 121", departureDate: Date(timeIntervalSince1970: 1574222400), terminal: "5", flightStatus: .Scheduled)
//2b. Use the Array append() method to add Flight's
var departures = DepartureBoard(flightList:[], currentAirport:"")
departures.flightList += [flight1, flight2, flight3]
//: ## 3. Create a free-standing function that can print the flight information from the `DepartureBoard`
//: a. Use the function signature: `printDepartures(departureBoard:)`
//:
//: b. Use a `for in` loop to iterate over each departure
//:
//: c. Make your `FlightStatus` enum conform to `String` so you can print the `rawValue` String values from the `enum`. See the [enum documentation](https://docs.swift.org/swift-book/LanguageGuide/Enumerations.html).
//:
//: d. Print out the current DepartureBoard you created using the function
//3a. Use the function signature: printDepartures(departureBoard:)
func printDepartures(departureBoard: DepartureBoard){
    //3b. Use a for in loop to iterate over each departure
    for departure in departureBoard.flightList{
        
        let departureTime: String = getFormattedDate(departure: departure)
        let terminal: String = getTerminal(departure: departure)
        //3d. Print out the current DepartureBoard you created using the function
        //4e. Your output should look like:
        print("Destination: \(departure.destination) Airline: \(departure.airLine) Flight: \(departure.flight) Departure Time: \(departureTime) Terminal: \(terminal) Status: \(departure.flightStatus)")
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
//4a. Createa new printDepartures2(departureBoard:) or modify the previous function
func getFormattedDate(departure: Flight)->String{
    /* 4b. Use optional binding to unwrap any optional values, use string interpolation to turn a non-optional
    date into a String */
    if let date = departure.departureDate{
        /* 4d. Stretch: Format the time string so it displays only the time using a DateFormatter look at the dateStyle
        (none), timeStyle (short) and the string(from:) method */
        let formatter = DateFormatter()
        //set format format
        formatter.dateFormat = "h:mm a 'PST'"
        //set originating timezone
        formatter.timeZone = TimeZone(abbreviation: "PST")
        //return formatted date
        let formattedDate = formatter.string(from: date)
        return formattedDate
    }
    return "TBD"
}
func getTerminal(departure:Flight)->String{
    /* 4b. Use optional binding to unwrap any optional values, use string interpolation to turn a non-optional
    date into a String */
    if let hasTerminal = departure.terminal{
        return hasTerminal
    }
    return "TBD"
}
//4c. Call the new or udpated function.
printDepartures(departureBoard: departures)


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
extension DepartureBoard{
    func flightAlert(){
        for flight in flightList{
            let terminal = getTerminal(departure: flight)
            let destination = flight.destination
            let departureDate = getFormattedDate(departure: flight)
            switch flight.flightStatus.rawValue{
            // 5e.
            case "EnRoute":
                print("You will arrive at your destination in 44 minutes.")
            // 5b.
            case "Scheduled":
                print("Your flight to \(destination) is scheduled to depart at \(departureDate) from terminal: \(terminal).")
            // 5a.
            case "Canceled":
                print("We're sorry your flight to \(destination) was canceled, here is a $500 voucher.")
            // 5e.
            case "Delayed":
                print("Your flight is delayed by 30 minutes due to weather conditions.")
            // 5c.
            case "Boarding":
                print("Your flight is boarding, please head to terminal: \terminal) immediately. The doors are closing soon.")
            default:
                break
            }
            // 5f.
            if (terminal == "TBD"){
                print("See the nearest information desk for more details.")
            }
        }
    }
}
// 5d.
departures.flightAlert()
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
    // 6a.
    let bagCost: Double = 25
    // 6b.
    let mileCost: Double = 0.10
    
    // 6c. Multiply the ticket cost by the number of travelers
    let ticketCost = Double(travelers) * ((mileCost * Double(distance)) + (bagCost * Double(checkedBags)))
    
    return ticketCost
}
// 6d. Call the function with a variety of inputs (2 bags, 2000 miles, 3 travelers = $750)
let travelCost = calculateAirfare(checkedBags: 2, distance: 2000, travelers: 3)

// 6f. Stretch: Use a NumberFormatter with the currencyStyle to format the amount in US dollars.
func convertDoubleToCurrency(amount: Double)->String{
    let numberFormatter = NumberFormatter()
    numberFormatter.numberStyle = .currency
    numberFormatter.currencyCode = "USD"
    return numberFormatter.string(from: NSNumber(value: amount))!
}
print(convertDoubleToCurrency(amount: travelCost))
