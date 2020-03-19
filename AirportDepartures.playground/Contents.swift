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
enum FlightsStatus: String { //a
    case canceled
    case enRoute
    case scheduled
    case boarding
    
}

struct Airport { //b
    var destination: String
    
}

struct Flight { //c
    var destination: Airport
    var airline: String
    var flightNumber: String
    var departureTime: Date? //d
    var terminal: String? //e
    var flightStatus: FlightsStatus
    

    
}



class DepartureBoard { //f
    let currentAirport: String
    var departureFlights: [Flight]
    
    
    init(currentAirport: String = "John F. Kennedy International - New York") {
        self.departureFlights = []
        self.currentAirport = currentAirport
    }
    
    func alertMessage() { //Creating Alerts for passangers
        for flights in departureFlights {
            var finalDate: String?
            
            if let unwrappedDate = flights.departureTime {
                let dateFormatter = DateFormatter()
                dateFormatter.dateStyle = .none
                dateFormatter.timeStyle = .short
                dateFormatter.locale = .current
                
                finalDate = dateFormatter.string(from: unwrappedDate)
            }
            
            switch flights.flightStatus {
            case .canceled:
                print("We're sorry your flight to \(flights.destination.destination) was canceled, here is a $500 voucher")
            case .boarding:
                print("Your flight to \(flights.destination.destination) is bording from terminal: \(flights.terminal ?? "TBT **see the nearest information desk for more details**")")
            case .scheduled:
                print("Your flight to \(flights.destination.destination) is scheduled to depart at \(finalDate ?? "TBT") from terminal: \(flights.terminal ?? "TBT **see the nearest information desk for more details**")")
            case .enRoute:
                print("Your flight to \(flights.destination.destination) is En Rout to depart at \(finalDate ?? "TBT") from terminal: \(flights.terminal ?? "TBT - **see the nearest information desk for more details**") is on time")
            default:
                print("Your flight does not exist. Please make sure you input correct flight number.")
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
let flight_1 = Flight(destination: .init(destination: "Los Angeles"), airline: "Virgin Australia", flightNumber: "VA6659", departureTime: nil, terminal: "4", flightStatus: .canceled)
let flight_2 = Flight(destination: .init(destination: "London"), airline: "British Airways", flightNumber: "BA4270", departureTime: Date(), terminal: "7", flightStatus: .boarding)
let flight_3 = Flight(destination: .init(destination: "Mexico"), airline: "El Al", flightNumber: "LY8213", departureTime: Date(), terminal: nil, flightStatus: .scheduled)
var board = DepartureBoard()
board.departureFlights.append(flight_1)
board.departureFlights.append(flight_2)
board.departureFlights.append(flight_3)
//: ## 3. Create a free-standing function that can print the flight information from the `DepartureBoard`
//: a. Use the function signature: `printDepartures(departureBoard:)`
//:
//: b. Use a `for in` loop to iterate over each departure
//:
//: c. Make your `FlightStatus` enum conform to `String` so you can print the `rawValue` String values from the `enum`. See the [enum documentation](https://docs.swift.org/swift-book/LanguageGuide/Enumerations.html).
//:
//: d. Print out the current DepartureBoard you created using the function
func printDepartures() {
    let flightsForDeparture = board.departureFlights
    for flight in flightsForDeparture {
        if let time = flight.departureTime {
            let time = time

            print("\(flight.destination)- destination\n\t\(flight.airline) - airline\n\t\(flight.flightNumber) - flight number\n\t\(time)) - departure time\n\t\(String(describing: flight.terminal)) - terminal\n\t\(flight.flightStatus.rawValue)")
        }
    }
}

printDepartures()

func printDepartures2() {
    let flightsForDeparture = board.departureFlights
    for flight in flightsForDeparture {
        var finalDate: String?
                  
                  if let unwrappedDate = flight.departureTime { //formating date 
                      let dateFormatter = DateFormatter()
                      dateFormatter.dateStyle = .none
                      dateFormatter.timeStyle = .short
                      dateFormatter.locale = .current
                      
                      finalDate = dateFormatter.string(from: unwrappedDate)
                  }
    print("Destination: \(flight.destination.destination)\nAirline: \(flight.airline)\nFLIGHT: \(flight.flightNumber)\nDeparture Time: \(finalDate ?? "NON")\nTerminal:\(flight.terminal ?? "NON")\nStatus: \(flight.flightStatus.rawValue)")
        
           }
    }
 
        
printDepartures2()
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
board.alertMessage()
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
func calculateAirfare(checkedBags: Int, distance: Int, travelers: Int) -> String { // In Order to show price in $'s return was switched to String
    let bagCost = 25
    let mileCost = 0.10
    let ticketCost = mileCost * Double(distance)
    let currencyFormatter = NumberFormatter()
    currencyFormatter.usesGroupingSeparator = true
    currencyFormatter.numberStyle = .currency
    currencyFormatter.locale = Locale.current
    let cost = (Double(bagCost) * Double(checkedBags) + ticketCost) * Double(travelers)
    let priceString = currencyFormatter.string(from: NSNumber(value: cost))!
    
    return priceString
    
}

calculateAirfare(checkedBags: 2, distance: 2000, travelers: 10)
