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
    case EnRouteOnTime = "On time and en route"
    case EnRouteDelayed = "Delayed and en route"
    case EnRouteAheadOfSchedule = "En route and ahead of schedule"
    case ScheduledOnTime = "On time as scheduled"
    case ScheduledDelayed = "Delayed"
    case LandedOnTime = "Landed on time"
    case LandedDelayed = "Delayed, and has landed"
    case Cancelled = "Cancelled"
    case Boarding = "Is boarding"
    }

struct AirportDestArrival {
    let cityName: String
    let cityCode: String
}

struct Flight {
    var flightStatus: FlightStatus
    var destinationCity: AirportDestArrival
    var arrivalCity: AirportDestArrival
    let flightNumber: String
    var departureTime: DateComponents?
    var terminal: String?
}

class DepartureBoard{
    var departureFlights: [Flight]
    
    init(departureFlight: String) {
        self.departureFlights = []
    }
    
    func passengerAlert(flights: [DepartureBoard]){
        for flight in departureFlights{
            if (flight.departureTime == nil) || (flight.terminal == nil){
            print("TBD")
            } else {for flight in departureFlights{
                switch flight.flightStatus {
                case .Cancelled:
                    print("We're sorry your flight to \(flight.destinationCity.cityName) was canceled, here is a $500 voucher.")
                case .Boarding:
                    if let terminal = flight.terminal{
                        print("Your flight is boarding, please head to \(terminal) immediately.  The doors are closing soon.")}
                case .EnRouteAheadOfSchedule, .EnRouteDelayed, .EnRouteOnTime, .LandedDelayed, .LandedOnTime, .ScheduledOnTime, .ScheduledDelayed:
                    if let terminal = flight.terminal,
                        let departureTime = flight.departureTime{
                        print("Your flight to \(flight.destinationCity.cityName) is scheduled to depart at \(departureTime) from \(terminal)")}
                default:
                  print("Please see the nearest servive desk.")
                }
            }
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


let calendar = Calendar.current
var timeZone = TimeZone(abbreviation: "EST")
var flight123 = Flight(flightStatus: .Boarding,
                       destinationCity: AirportDestArrival(cityName: "Los Angeles", cityCode: "Lax"),
                       arrivalCity: AirportDestArrival(cityName: "McCarran International", cityCode:"LAS"),
                       flightNumber: "LM123",
                       departureTime: DateComponents(calendar: calendar, timeZone: timeZone, year: 2020, month: 1, day: 3, hour: 13, minute: 0),
                       terminal: "Terminal 4")
var flight456 = Flight(flightStatus: .EnRouteOnTime,
                       destinationCity: AirportDestArrival(cityName: "Miami International", cityCode: "MIA"),
                       arrivalCity: AirportDestArrival(cityName: "John F Kennedy International", cityCode: "JFK"),
                       flightNumber: "MF456",
                       departureTime: DateComponents(calendar: calendar, timeZone: timeZone, year: 2020, month: 1, day: 3, hour: 8, minute: 30),
                       terminal: "Terminal 5")
var flight789 = Flight(flightStatus: .Cancelled,
                       destinationCity: AirportDestArrival(cityName: "Dallas/Fort Worth International", cityCode: "DFW"),
                       arrivalCity: AirportDestArrival(cityName: "Chicago Midway International", cityCode: "MDW"),
                       flightNumber: "MD789",
                       departureTime: nil,
                       terminal: nil)

var departureBoardJFK = DepartureBoard(departureFlight: "JFK")
departureBoardJFK.departureFlights.append(flight123)
departureBoardJFK.departureFlights.append(flight456)
departureBoardJFK.departureFlights.append(flight789)





//: ## 3. Create a free-standing function that can print the flight information from the `DepartureBoard`
//: a. Use the function signature: `printDepartures(departureBoard:)`
//:
//: b. Use a `for in` loop to iterate over each departure
//:
//: c. Make your `FlightStatus` enum conform to `String` so you can print the `rawValue` String values from the `enum`. See the [enum documentation](https://docs.swift.org/swift-book/LanguageGuide/Enumerations.html).
//:
//: d. Print out the current DepartureBoard you created using the function
func printDepartures (departureBoard: DepartureBoard){
    for flights in departureBoard.departureFlights {
        var string1 = ""
        if let departureTime = flights.departureTime {
            string1 = "\(departureTime)"
        }
        var string2 = ""
        if let terminal = flights.terminal{
            string2 = "\(terminal)"
            }
        print("Flight Number: \(flights.flightNumber) Arriving from: \(flights.arrivalCity.cityCode)/\(flights.arrivalCity.cityName) Destination: \(flights.destinationCity.cityCode)/\(flights.destinationCity.cityName) Flight Status: \(flights.flightStatus.rawValue) Departing at: \(string1) From: \(string2)")
        }
    }


printDepartures(departureBoard: departureBoardJFK)


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

//need to date format


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


    func calculateAirfare(checkedBags: Int, seatCost: Int, travelers: Int) -> Double {
        let doubleSeatCost = Double(seatCost)
        let doubleCheckedBags = Double(checkedBags)
        let doubleTravelers = Double(travelers)
        let bagTotal = doubleCheckedBags * 25
        let passengerTotal = doubleSeatCost * doubleTravelers
        let totalFare = bagTotal + passengerTotal
        print("\(totalFare)")
        return totalFare
}

calculateAirfare(checkedBags: 4, seatCost: 140, travelers: 2)
calculateAirfare(checkedBags: 3, seatCost: 95, travelers: 1)
calculateAirfare(checkedBags: 1, seatCost: 130, travelers: 4)
