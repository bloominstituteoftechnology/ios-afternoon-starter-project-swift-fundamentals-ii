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
//Part 1
//a
enum FlightStatus: String {
	case enRoute, scheduled, canceled, boarding, missing
}

//b
struct AirportRoute {
	var departure: String
	var arrival: String
}

//c
struct Flight {
	var airline: String
	var refCode: String
	var status: FlightStatus
	var route: AirportRoute
	//d
	var departureTime: Date?
	//e
	var terminal: String?
}

//f
class DepartureBoard {
	var airport: String
	var flights: [Flight]
	
	init(airport: String) {
		self.airport = airport
		flights = []
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
//Part 2
//a
var flightBoard = DepartureBoard(airport: "LaGuardia Airport")

var flight1Route = AirportRoute(departure: "LGA", arrival: "MIA")
var flight1 = Flight(airline: "Spirit", refCode: "BR 219", status: .scheduled, route: flight1Route, departureTime: Date(), terminal: "2")

var flight2Route = AirportRoute(departure: "LGA", arrival: "SFO")
var flight2 = Flight(airline: "British Airways", refCode: "TL 347", status: .scheduled, route: flight1Route, departureTime: Date(), terminal: "4")

//b
flightBoard.flights.append(flight1)
flightBoard.flights.append(flight2)

//c
flightBoard.flights[0].status = .canceled

//d
flightBoard.flights[0].terminal = nil

//e
var datecomponents = DateComponents()
datecomponents.calendar = .current
datecomponents.year = 2019
datecomponents.month = 9
datecomponents.day = 21
if let futureDate = datecomponents.date {
	print(futureDate)
}
//: ## 3. Create a free-standing function that can print the flight information from the `DepartureBoard`
//: a. Use the function signature: `printDepartures(departureBoard:)`
//:
//: b. Use a `for in` loop to iterate over each departure
//:
//: c. Make your `FlightStatus` enum conform to `String` so you can print the `rawValue` String values from the `enum`. See the [enum documentation](https://docs.swift.org/swift-book/LanguageGuide/Enumerations.html).
//:
//: d. Print out the current DepartureBoard you created using the function


//Part 3
//a
func printDepartures(departureBoard: DepartureBoard) {
	//b
	for flight in departureBoard.flights {
		print("The flight to \(flight.route.arrival) is \(flight.status)")
	}
}

//d
printDepartures(departureBoard: flightBoard)
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
//Part 4
//a
func printDepartures2(departureBoard: DepartureBoard) {
	//b
	for flight in departureBoard.flights {
		//c
		if let terminal = flight.terminal {
			print("""
				
				Destination: \(flight.route.arrival)
				Airline: \(flight.airline)
				Flight: \(flight.refCode)
				Departure Time: \(format(departureTime: flight.departureTime))
				Terminal: \(terminal)
				Status \(flight.status)
				
				""")
		}
	}
}

//d
func format(departureTime: Date?) -> String {
	guard let date = departureTime else { return "TBD" }
	let dateFormatter = DateFormatter()
	dateFormatter.dateStyle = .short
	return dateFormatter.string(from: date)
}

printDepartures2(departureBoard: flightBoard)
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
//Part 5
extension DepartureBoard {
	func alertPassengers() {
		for flight in flights {
			switch flight.status {
			//a
			case .canceled:	print("We're sorry your flight to \(flight.route.arrival) was canceled, here is a $500 voucher.")
			//b,d
			case .scheduled: print("Your flight to \(flight.route.arrival) is scheduled to depart at \(format(departureTime: flight.departureTime)) from terminal: \(flight.terminal ?? "TBD").")
			//c
			case .boarding:	print("Your flight is boarding, please head to terminal: \(flight.terminal ?? "TBD") immediately. The doors are closing soon.")
			//e
			default:
				print("Please check the departure board app for the status of your flight.")
			}
			
			//f
			if flight.terminal == nil {
				print("Please see the nearest information desk for more details.")
			}
		}
	}
}

flightBoard.alertPassengers()

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
//Part 6
func calculateAirfare(checkedBags:Int, distance: Int, travelers: Int) -> String {
	//a
	let costPerBag = 25
	//b
	let costPerMile = 0.10
	//e
	let bagPrice = Double(costPerBag * checkedBags)
	let costPerTicket = costPerMile * Double(distance)
	//c
	let ticketPrice = costPerTicket * Double(travelers)
	let totalPrice = ticketPrice + bagPrice
	
	return "\nTotal flight cost: \(currencyFormatter(amount: totalPrice))"
}

//f
func currencyFormatter(amount: Double) -> String {
	let nsAmount = NSNumber(value: amount)
	let currrencyFormatter = NumberFormatter()
	currrencyFormatter.numberStyle = .currency
	if let amountString = currrencyFormatter.string(from: nsAmount) {
		return amountString
	}
	return "$0.00"
}

//d
print(calculateAirfare(checkedBags: 6, distance: 2000, travelers: 3))
