//: [Previous](@previous)
import Foundation


enum FlightStatus {
    case enRoute
    case scheduled
    case canceled
    case delayed
    case landed
    case boarding
}



struct ArrivalAirport {
    let name: String
    let city: String
}


struct DepartureFlight {
    var destination: String
    var airline: String
    var flight: String
    var departureDate: Date?
    var terminal: String?
    var status: FlightStatus
}



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



var flightOne = DepartureFlight(destination: "London, England", airline: "Virgin Airlines", flight: "VA 100", departureDate: Date(), terminal: "7", status: .boarding)

var flightTwo = DepartureFlight(destination: "San Francisco, CA", airline: "American Airlines", flight: "AA 180", departureDate: Date(), terminal: "AA 210", status: .enRoute)

var flightThree = DepartureFlight(destination: "Juniper, Alaska", airline: "Alaskan Airlines", flight: "AL 80", departureDate: Date(), terminal: "2", status: .scheduled)


jfkDepartureBoard.add(flight: flightOne)
jfkDepartureBoard.add(flight: flightTwo)
jfkDepartureBoard.add(flight: flightThree)



flightThree.status = .canceled
flightThree.departureDate = nil



flightThree.terminal = nil





func printDepartures(departureBoard: DepartureBoard){
    for flight in departureBoard.departureFlights {
        print(flight.departureDate ?? "Canceled")
    }
}



func calculateAirfare(checkedBags: Int, distance: Int, travelers: Int) -> Double {
    let bagCost = Double(checkedBags) * 25
    let mileCost = Double(distance) * 0.10
    let ticketCost: Double = bagCost + mileCost
    let totalTicketCost = ticketCost * Double(travelers)
    
    return totalTicketCost
}

calculateAirfare(checkedBags: 2, distance: 1300, travelers: 3)



//: [Next](@next)

