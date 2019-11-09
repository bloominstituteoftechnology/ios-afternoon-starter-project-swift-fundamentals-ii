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
    case En_Route
    case Scheduled
    case Canceled
    case Delayed
    case Boarding
}

struct Airport {
    var destinationCity: String
    var airportCallName: String
    
}

struct Airline {
    var name: String
    var callName: String
}

struct Flight {
    let flightNumber: String
    let airline: Airline
    let callName: String
    let departureTime: String?
    let scheduledDepartureTime: String
    let scheduledArrivalTime: String
    let estimatedArrivalTime: String
    let terminal: String?
    let gate: String?
    let flightStatus: FlightStatus
    let departureAirport: Airport
    let arrivalAirport: Airport
    let date: Date?
    
}

class DepartureBoard {
    var flightList: [Flight]
    let airport: Airport
    
    
    init(airport: Airport) {
        self.airport = airport
        self.flightList = []
        
        
    }
    func passengerAlert() {
        for flights in flightList {
            
            switch flights.flightStatus {
            case FlightStatus.Canceled:
                print("We're sorry your flight to \(flights.arrivalAirport.destinationCity) was canceled, here is a $500 voucher")
            case FlightStatus.Scheduled:
                print("Your flight to \(flights.arrivalAirport.destinationCity) is scheduled to depart at \(flights.scheduledDepartureTime) from terminal: \(flights.terminal!)")
            case FlightStatus.Boarding:
                print("Your flight is boarding, please head to terminal: \(flights.terminal!) immediately. The doors are closing soon.")
            case FlightStatus.Delayed:
                print("We're sorry your flight to \(flights.arrivalAirport.destinationCity) has been delayed. Thank you for flying with \(flights.airline.name)")
            case FlightStatus.En_Route:
                print("Thank you for flying with \(flights.airline.name) we are currently \(FlightStatus.En_Route) hope you enjoy \(flights.arrivalAirport.destinationCity)")
            default:
                print("No status available.")
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

let jetBlue = Airline(name: "JetBlue", callName: "JBU")
let americanAirlines = Airline(name: "American Airlines", callName: "AAL")
let qantas = Airline(name: "Qantas", callName: "QF")

let arrivingAirport = Airport(destinationCity: "Los Angeles", airportCallName: "LAX")
let departureAirport = Airport(destinationCity: "New York", airportCallName: "JFK")

let jetBlueFlight = Flight(flightNumber: "B6 23", airline: jetBlue, callName: "JBU", departureTime: "05:30 am", scheduledDepartureTime: "05:40 am", scheduledArrivalTime: "08:51 am", estimatedArrivalTime: "08:51 am", terminal: "4", gate: "59", flightStatus: .En_Route, departureAirport: departureAirport, arrivalAirport: arrivingAirport, date: Date())

let americanAirlineFlight = Flight(flightNumber: "AA 171", airline: americanAirlines, callName: "AAL" , departureTime: nil, scheduledDepartureTime: "06:00 am", scheduledArrivalTime: "09:28 am", estimatedArrivalTime: "09:31 am", terminal: nil, gate: "42A", flightStatus: .Canceled, departureAirport: departureAirport, arrivalAirport: arrivingAirport, date: Date())

let qantasFlight = Flight(flightNumber: "QF 3213", airline: qantas, callName: "QF", departureTime: "05:54 am", scheduledDepartureTime: "06:00 am", scheduledArrivalTime: "09:28 am", estimatedArrivalTime: "09:33 am", terminal: "4", gate: "42A", flightStatus: .Boarding, departureAirport: departureAirport, arrivalAirport: arrivingAirport, date: Date())


var departureBoard = DepartureBoard(airport: departureAirport)

departureBoard.flightList.append(americanAirlineFlight)
departureBoard.flightList.append(jetBlueFlight)
departureBoard.flightList.append(qantasFlight)



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
    
        
        print("\nDate: \(flight.departureTime) \n\tFlight Status: \(flight.flightStatus) Departure Time: \(flight.departureTime)  Airline: \(flight.airline.name), Call Name: \(flight.callName) flight number: \(flight.flightNumber)\n\tFlight To: \(arrivingAirport.destinationCity) Estimated Arrival Time: \(flight.estimatedArrivalTime ?? "") Scheduled Arrival Time: \(flight.scheduledArrivalTime) Terminal: \(flight.terminal ?? "") Gate: \(flight.gate ?? "")")
       
    }
}

printDepartures(departureBoard: departureBoard)




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
func printDepartures2(depatureBoard: DepartureBoard) {
    
    for flight in depatureBoard.flightList {
        
        if let timeDeparture = flight.departureTime {
            print("\(timeDeparture)")
        } else {
            print("")
        }
        
    }
}

printDepartures2(depatureBoard: departureBoard)


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


departureBoard.passengerAlert()

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
    let checkedBagCost: Int = 25 * checkedBags
    let costPerMile: Double = 0.10 * Double(distance)
    let costofAirfare: Double = costPerMile + Double(checkedBagCost)
    let costperTraveler = costofAirfare * Double(travelers)
   
    return costperTraveler
}

let familyTripCost = calculateAirfare(checkedBags: 2, distance: 2000, travelers: 3)
print(familyTripCost)


