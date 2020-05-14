import UIKit
/// 1 / / /
/// A / / /
enum FlightStatus: String {
    case EnRoute = "EnRoute"
    case Scheduled = "Scheduled"
    case Canceled = "Canceled"
    case Delayed = "Delayed"
    case Boarding = "Boarding"
}
/// B / / /
struct Airport {
    let Destination: String
    let Arrival: String
}

/// C, D, and E / / /
struct Flight {
    var depaturetime: Date?
    var terminal: String?
    var FlightStatus: FlightStatus
}

/// F / / /
class DepartureBoard {
    var NewYork = "JFK"
    var Boston = "SFO"
    var SFO = "Denver"
    var departures: [Flight] = []
}
/// Again, I know to create a function but I'm just not sure which class, struct, enum this data is being assiged to / / / 
    func alertPassengers() {
        for departure in Flight {
            switch departure.status {
            case .cancelled:
                print("We're sorry your flight to (city) was canceled, here is a $500 voucher")
            case .enRouteDelayed:
                print("Your flight to \(departure.destination) is en route but delayed.")
            case .scheduled:
                print("Your flight to (city) is scheduled to depart at (time) from terminal: (terminal)")
            case .boarding:
                print("Your flight is boarding, please head to terminal: (terminal) immediately. The doors are closing soon.")
            }
        }
    }


/// 2 / / /
var Flight1 = Flight(depaturetime: Date(), terminal: "B7", FlightStatus: .Delayed)
var Flight2 = Flight(depaturetime: Date(), terminal: "N9", FlightStatus: .Canceled)
var Flight3 = Flight(depaturetime: Date(), terminal: "nil", FlightStatus: .Scheduled)

let Departures = [Flight1, Flight2, Flight3]
print(Departures)

/// E / / /
var date = DateComponents()
date.year = 2020
date.month = 05
date.day = 13
date.timeZone = TimeZone(abbreviation: "PST")
date.hour = 12
date.minute = 34
date.second = 55


/// 3 / / /
func printDepartures(departureBoard: DepartureBoard) {
    for _ in departureBoard.departures {
        let departure1 = FlightStatus.EnRoute.rawValue
        let departure2 = FlightStatus.Scheduled.rawValue
        let departure3 = FlightStatus.Canceled.rawValue
        let departure4 = FlightStatus.Delayed.rawValue
    }
print(departureBoard)
}


/// 4 / / / I struggled with this section of unwritting the optionals. I don't understand which statements I should reference here to get them unbinded. ///

func printDepartures2(departureBoard: DepartureBoard) {
    if let depture = depaturetime {
        print("Departure: \(departureTime.self) Terminal: \(terminal.self) Status: \(FlightStatus.self)")
}
