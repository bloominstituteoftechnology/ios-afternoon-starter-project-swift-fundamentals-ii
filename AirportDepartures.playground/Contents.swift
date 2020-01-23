import UIKit

// Step 1
enum FlightStatus: String {
    case enRoute
    case scheduled
    case delayed
    case cancelled
}

struct Airport {
    var destination: String
}

struct Flight {
    var airline: String
    var flightNumber: String
    var departure: Date?
    var terminal: String?
    var status: FlightStatus
    var city: String
}

class DepartureBoard {
    var airport: Airport
    var flights: [Flight]
    init(airport: Airport) {
        self.airport = airport
        flights = []
    }
    
    // Step 5
    func alert() {
        var terminalVal: String
        var departureVal: String
        
        for flight in flights {
            if let terminal = flight.terminal {
                terminalVal = terminal
            } else {
                terminalVal = "TBD"
            }
            if let departure = flight.departure {
                let formatter = DateFormatter()
                formatter.dateFormat = "h:mm a"
                departureVal = formatter.string(from: departure)
            } else {
                departureVal = "TBD"
            }
            switch(flight.status) {
                case .cancelled:
                    print("We're sorry your flight to \(flight.city) was cancelled, here's a $500 voucher")
                case .delayed:
                    print("Your flight to \(flight.city) was delayed")
                case .scheduled:
                    print("Your flight to \(flight.city) is scheduled to depart at \(departureVal), from terminal \(terminalVal)")
                default:
                    print("Your flight to \(flight.city) is boarding, please head to terminal \(terminalVal) immediately. The doors are closing soon")
            }
        }
    }
}

// Step 2
let flight1 = Flight(airline: "American Airlines", flightNumber: "AA2896", departure: Date(), terminal: "8", status: .enRoute, city: "Los Angeles")

let flight2 = Flight(airline: "Finnair", flightNumber: "AY5747", departure: Date(), terminal: "6", status: .enRoute, city: "New York")

let flight3 = Flight(airline: "Qantas", flightNumber: "QF12", departure: Date(), terminal: "4", status: .delayed, city: "San Francisco")

let myAirport = Airport(destination: "Georgetown")

let departureBoard = DepartureBoard(airport: myAirport)
departureBoard.flights.append(flight1)
departureBoard.flights.append(flight2)
departureBoard.flights.append(flight3)

// Step 3
func printDepartures(departureBoard: DepartureBoard) {
    for departure in departureBoard.flights {
        print(departure)
    }
}
print("\n")
printDepartures(departureBoard: departureBoard)

// Step 4
func printDepartures2(departureBoard: DepartureBoard) {
    for departure in departureBoard.flights {
        var departureVal: String
        var terminalVal: String
        
        if let departure = departure.departure {
            // Convert Date() --> String
            let formatter = DateFormatter()
            formatter.dateFormat = "h:mm a"
            departureVal = formatter.string(from: departure)
        } else {
            departureVal = "TBD"
        }
        
        if let terminal = departure.terminal {
            terminalVal = terminal
        } else {
            terminalVal = "TBD"
        }
        print("Destination: \(departure.city) | Airline: \(departure.airline) | Flight: \(departure.flightNumber) | Departure Time: \(departureVal) | Terminal: \(terminalVal) | Status: \(departure.status.rawValue)")
    }
}
print("\n")
printDepartures2(departureBoard: departureBoard)
// Step 5 function is in DepartureBoard Class
print("\n")
departureBoard.alert()

// Step 6
func calculateAirfare(checkedBags: Int, distance: Int, travelers: Int) -> Double {
    var total: Double = 0
    total += Double(25 * checkedBags)
    total += 0.1 * Double(distance)
    total *= Double(travelers)
    return total
}

print("\nBags: 2, Miles: 2000, Travelers: 3 = $\(calculateAirfare(checkedBags: 2, distance: 2000, travelers: 3))")
