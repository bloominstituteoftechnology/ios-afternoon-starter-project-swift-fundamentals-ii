import UIKit


enum FlightStatus: String {
    case EnRoute = "En Route"
    case Landed = "Landed"
    case Scheduled = "Scheduled"
    case Delayed = "Delayed"
    case Canceled = "Canceled"
    case Boarded = "Boarding"
}

struct Airport {
    let name: String
    let symbol: String
}

struct Flight {
    let destination: Airport
    var departure: Date?
    var flightNumber: String
    let airline: String
    let terminal: String?
    let status: FlightStatus
}




class DepartureBoard {
    var currentFlight: [Flight]
    var currentAirport: String
    
    init (currentFlight: [Flight], currentAirport: String) {
        self.currentFlight = currentFlight
        self.currentAirport = currentAirport
    }
    func addFlight() {
        currentFlight.append(contentsOf: allFlights)
    }
    // func noFlight () {
    //   for airport in flight {
    //     print("There are no flights today.") }
    func alertPassengers() {
        for flight in allFlights {
            if flight.status == .Canceled {
                print("We're sorry your flight to \(flight.destination) was canceled due to coronavirus, here is $500 voucher." )
            } else if flight.status == .Scheduled {
                print("Your flight to \(flight.destination) is scheduled to depart at \(flight.departure ?? Date()) from terminal: \(flight.terminal ?? "TBD"). Be sure to wear a mask and bring hand sanitizer.")
            } else if flight.status == .Boarded {
                print("Your flight is boarding, please head to terminal: \(flight.terminal ?? "TBD") immediately. The doors are closing soon.")
            }
        }
        
    }
}



let board = DepartureBoard(currentFlight: [], currentAirport: "JFK")
        
let flight1 = Flight(destination: "Atlanta", departure: Date (), flightNumber: "DL1104", airline: "Delta", terminal: "4", status: .Canceled)

let flight2 = Flight(destination: "London", departure: Date(), flightNumber: "AA6135", airline: "American Airlines", terminal: "8", status: .Boarded)

let flight3 = Flight(destination: "Toronto", departure: Date(), flightNumber: "CX85", airline: "Cathay Pacific", terminal: nil, status: .Scheduled)

let allFlights = [flight1, flight2, flight3]

board.addFlight()

func printDepartureBoard (departureBoard: DepartureBoard) {
  for flight in allFlights {
    print(flight)
    }
}

printDepartureBoard(departureBoard: board)


//    Destination: Los Angeles Airline: Delta Air Lines Flight: KL 6966 Departure Time:  Terminal: Status: Canceled
func printDepartures2 (departureBoard: DepartureBoard) {
    
    let dateFormat = DateFormatter()
    dateFormat.dateStyle = .none
    dateFormat.timeStyle = .short
    
    for flight in allFlights {
        
    var terminal = ""
    var departure = ""
        
        if let unwrappedDeparture = flight.departure {
            departure = dateFormat.string(from: unwrappedDeparture)
        }
        
        if let unwrappedTerminal = flight.terminal {
            terminal = unwrappedTerminal
        }
        print("Destination: \(flight.destination) Airline: \(flight.airline) \(flight.flightNumber) Departure Time: \(departure) Terminal: \(terminal) Status: \(flight.status.rawValue)")

    }
}

printDepartures2(departureBoard: board)

board.alertPassengers()

func calculateAirfare(checkedBags: Int, distance: Double, travelers: Int) -> Double {
    
   // let currencyFormat = NumberFormatter()
    // currencyFormat.numberStyle = String? { $ }
    
    let costOfBags = Double(checkedBags) * 25
    let costOfTicket = Double(distance) * 0.10
    let totalTicketCost: Double = (costOfTicket * Double(travelers)) + Double(costOfBags)
    
return totalTicketCost
    
}

calculateAirfare(checkedBags: 4, distance: 3500, travelers: 1)
calculateAirfare(checkedBags: 1, distance: 517.22, travelers: 1)
calculateAirfare(checkedBags: 12, distance: 7822.83, travelers: 8)

