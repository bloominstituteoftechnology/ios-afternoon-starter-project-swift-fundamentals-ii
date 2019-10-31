import Foundation

// flight status
enum FlightStatus: String {
    case boarding = "Boarding"
    case scheduled = "Scheduled"
    case canceled = "Canceled"
    case delayed = "Delayed"
}

// destination airport blueprint
struct Airport {
    let city: String
}

// flight blueprint
struct Flight {
    let number: Int
    let time: Date?
    let terminal: String?
    let destination: Airport
    let status: FlightStatus
    
}

// departure board
class DepartureBoard {
    var departures: [Flight]
    
    init(departures: [Flight]) {
        self.departures = departures
    }
    
    func alertPassengers() {
        for departure in departures {
            switch departure.status {
            case .boarding:
                print("Your flight is boarding, please head to terminal: \(departure.terminal!) immediately. The doors are closing soon.")
            case .canceled:
                print("We're sorry your flight to \(departure.destination.city) was canceled, here is a $500 voucher")
            case .delayed:
                print("Flight \(departure.number) will be delayed. Thanks for your patience.")
            case .scheduled:
                print("Flight \(departure.number) to \(departure.destination) will be boarding on schedule.")
            default:
                print("error - no alert case found")
            }
        }
    }
}

// add 3 flights to the departure board
let flight1 = Flight(number: 2319, time: Date(), terminal: "A", destination: Airport(city: "Los Angeles"), status: .scheduled)
let flight2 = Flight(number: 1234, time: Date(), terminal: nil, destination: Airport(city: "Manhattan"), status: .delayed)
let flight3 = Flight(number: 2233, time: Date(), terminal: nil, destination: Airport(city: "Salt Lake City"), status: .canceled)

let dallasDepartureBoard = DepartureBoard(departures: [])
dallasDepartureBoard.departures.append(flight1)
dallasDepartureBoard.departures.append(flight2)
dallasDepartureBoard.departures.append(flight3)

// func that prints flight info from dallasdb

//func printDepartures(departureBoard: DepartureBoard) {
//    for departures in departureBoard.departures {
//        print(departures)
//    }
//}
//printDepartures(departureBoard: dallasDepartureBoard)

// second function
func printDepartures2(departureBoard: DepartureBoard) {
    for departures in departureBoard.departures {
        let unwrappedTerminal = departures.terminal ?? "None"
        guard let unwrappedTime = departures.time else { return }
        print("Destination: \(departures.destination.city), Flight: \(departures.number), Terminal: \(unwrappedTerminal), Departure Time: \(unwrappedTime), Status: \(departures.status.rawValue)")
}
}
printDepartures2(departureBoard: dallasDepartureBoard)

// alert function
dallasDepartureBoard.alertPassengers()

// calculate airfare
func calculateAirfare(checkedBags: Int, distance: Int, travelers: Int) -> Double {
    let bagPrice: Double = 25.00 * Double(checkedBags)
    let milePrice: Double = 0.10 * Double(distance)
    let sum: Double = bagPrice + milePrice
    let ticketPrice: Double = sum * Double(travelers)
    return ticketPrice
}

print(calculateAirfare(checkedBags: 2, distance: 2000, travelers: 3))
print(calculateAirfare(checkedBags: 4, distance: 1000, travelers: 4))
print(calculateAirfare(checkedBags: 1, distance: 500, travelers: 1))

