//: [Previous](@previous)
import Foundation

//1. Create custom types to represent an Airport Departures display


//a. Use an enum type for the FlightStatus (En Route, Scheduled, Canceled, Delayed, etc.)

enum FlightStatus {
    case enRoute
    case scheduled
    case canceled
    case delayed
    case landed
    case boarding
}

//b. Use a struct to represent an Airport (Destination or Arrival)

struct ArrivalAirport {
    let name: String
    let city: String
}


//c. Use a struct to represent a Flight.
//d. Use a Date? for the departure time since it may be canceled.
//e. Use a String? for the Terminal, since it may not be set yet (i.e.: waiting to arrive on time)

struct DepartureFlight {
    var destination: String
    var airline: String
    var flight: String
    var departureDate: Date?
    var terminal: String?
    var status: FlightStatus
}


//f. Use a class to represent a DepartureBoard with a list of departure flights, and the current airport

//5. Add an instance method to your DepatureBoard class (above) that can send an alert message to all passengers about their upcoming flight. Loop through the flights and use a switch on the flight status variable.

//a. If the flight is canceled print out: "We're sorry your flight to (city) was canceled, here is a $500 voucher"
//b. If the flight is scheduled print out: "Your flight to (city) is scheduled to depart at (time) from terminal: (terminal)"
//c. If their flight is boarding print out: "Your flight is boarding, please head to terminal: (terminal) immediately. The doors are closing soon."
//d. If the departureTime or terminal are optional, use "TBD" instead of a blank String
//e. If you have any other cases to handle please print out appropriate messages
//d. Call the alertPassengers() function on your DepartureBoard object below
//f. Stretch: Display a custom message if the terminal is nil, tell the traveler to see the nearest information desk for more details.


class DepartureBoard {
    var departureFlights: [DepartureFlight]
    var currentAirport: [ArrivalAirport]
    var flightStatus: [FlightStatus]
    
    init(){
        departureFlights = []
        currentAirport = []
        flightStatus = []
    }
    func alertPassenger(city: String, time: String, terminal: Int){
        for flight in departureFlights{
            switch flight.status {
            case FlightStatus.canceled:
                print("We're sorry your flight to \(city) was canceled, here is a $500 voucher")
            case FlightStatus.scheduled:
                print("our flight to \(city) is scheduled to depart at \(time) from terminal: \(terminal)")
            case FlightStatus.boarding:
                print("Your flight is boarding, please head to terminal: \(terminal) immediately. The doors are closing soon.")
            default:
                print("Your flight is on time!")
            }
            
            alertPassenger(city: "Miami, FL", time: "12:30 AM", terminal: 4)
        }
    }
    func add(flight: DepartureFlight) {
        departureFlights.append(flight)
    }
    
    }
   


let jfkDepartureBoard = DepartureBoard()



//2. Create 3 flights and add them to a departure board
//a. For the departure time, use Date() for the current time

var flightOne = DepartureFlight(destination: "London, England", airline: "Virgin Airlines", flight: "VA 100", departureDate: Date(), terminal: "7", status: .boarding)

var flightTwo = DepartureFlight(destination: "San Francisco, CA", airline: "American Airlines", flight: "AA 180", departureDate: Date(), terminal: "AA 210", status: .enRoute)

var flightThree = DepartureFlight(destination: "Juniper, Alaska", airline: "Alaskan Airlines", flight: "AL 80", departureDate: Date(), terminal: "2", status: .scheduled)

//b. Use the Array append() method to add Flight's

jfkDepartureBoard.add(flight: flightOne)
jfkDepartureBoard.add(flight: flightTwo)
jfkDepartureBoard.add(flight: flightThree)


//c. Make one of the flights .canceled with a nil departure time

flightThree.status = .canceled
flightThree.departureDate = nil


//d. Make one of the flights have a nil terminal because it has not been decided yet.

flightThree.terminal = nil

//e. Stretch: Look at the API for DateComponents for creating a specific time





//3. Create a free-standing function that can print the flight information from the DepartureBoard

//a. Use the function signature: printDepartures(departureBoard:)
//b. Use a for in loop to iterate over each departure
//c. Make your FlightStatus enum conform to String so you can print the rawValue String values from the enum. See the enum documentation.
//d. Print out the current DepartureBoard you created using the function


//4. Make a second function to print print an empty string if the departureTime is nil

//a. Createa new printDepartures2(departureBoard:) or modify the previous function
//b. Use optional binding to unwrap any optional values, use string interpolation to turn a non-optional date into a String
//c. Call the new or udpated function. It should not print Optional(2019-05-30 17:09:20 +0000) for departureTime or for the Terminal.
//d. Stretch: Format the time string so it displays only the time using a DateFormatter look at the dateStyle (none), timeStyle (short) and the string(from:) method
//e. Your output should look like:


func printDepartures(departureBoard: DepartureBoard){
    for flight in departureBoard.departureFlights {
        print(flight.departureDate ?? "Canceled")
    }
}


//6. Create a free-standing function to calculate your total airfair for checked bags and destination
//Use the method signature, and return the airfare as a Double
//a. Each bag costs $25
//b. Each mile costs $0.10
//c. Multiply the ticket cost by the number of travelers
//d. Call the function with a variety of inputs (2 bags, 2000 miles, 3 travelers = $750)
//e. Make sure to cast the numbers to the appropriate types so you calculate the correct airfare

func calculateAirfare(checkedBags: Int, distance: Int, travelers: Int) -> Double {
    let bagCost = Double(checkedBags) * 25
    let mileCost = Double(distance) * 0.10
    let ticketCost: Double = bagCost + mileCost
    let totalTicketCost = ticketCost * Double(travelers)
    
    return totalTicketCost
}

calculateAirfare(checkedBags: 2, distance: 1300, travelers: 3)



//: [Next](@next)

