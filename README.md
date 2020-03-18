# Airport Departures - Swift Fundamentals II Starter Project

![Airport Departures Display](images/matthew-smith-5934-unsplash.jpg)

JFK Airport needs you to help them design a new iPhone app to display departure information on upcoming flights.

They need your help in determining what data needs to be displayed to the user, and how to handle situations when fights are canceled, delayed, or there isn't information due to various situations.

Help them design logic that can alert customers about upcoming flights and price estimates for airfare (including checked bags).

## Instructions

Today's afternoon project is a Playground that will reinforce the topics that you covered in today's guided project.

1. Please fork and clone this repository.
2. Answer all of the questions in the AirportDepartures.playground file 

## Objectives

After completing this assignment, you should ... 

* be able to create custom types with `enum`, `struct`, and `class` 
* be able to unwrap optional variables safely and display appropriate placeholders
* be able to use a `switch` statement to control the logic in an app
* understand how to create a free-standing function
* understand how to add a method to a `class` or `struct` type
* be able to write calculations involving `Int` and `Double` types

## Required Features

* Answer all of the questions in the Playground file
* Make sure you address each required item

## Stretch Goals

* There are stretch goals at the bottom of questions (marked "Stretch:") to help you explore different APIs (Application Programming Interface)
	* `NumberFormatter`, `DateFormatter`, etc.
	* Use the links and hints to research these different APIs (you'll need to read the documentation)


// Step 1
enum FlightStatus: String {
    case enRoute = "EnRoute"
    case nowBoarding = "Now Boarding"
    case ontime = "Scheduled  - On Time"
    case delayed = " Scheduled - Delayed"
    case canceled = "Canceled"
}

struct Airport {
    let city: String
    let airportName: String
    let airportCode: String
}

struct Flight {
    var flightNumber: String
    var airline: String
    var destination: String
    var departureTime: Date?
    var terminal: String?
    var status: FlightStatus
    
}

class DepartureBoard {
    var departures: [Flight]
    var currentAirport: Airport
    
    init (currentAirport: Airport, departures: [Flight] = []) {
    
    self.departures = departures
    self.currentAirport = currentAirport
    }
    
    // Added func to accomodate instructions for Step 5
    
    func alertPassengers() {
    let flightTime = DateFormatter()
        flightTime.timeStyle = .short
    
    for flights in departures {
        
        switch flights.status {
        case .canceled:
            print("We're sorry your flight to \(flights.destination) was canceled, here is a $500 voucher")
            
        case .ontime:
            var departureTime = "TBD"
            var departTerminal = "TBD"
            if let time = flights.departureTime {
                departureTime = flightTime.string(from: time)
            }
            if let departTerminal = flights.terminal {
                print("Your flight to \(flights.destination) is scheduled to depart at \(departureTime) from terminal \(departTerminal)")
            } else {
                print("Your flight to \(flights.destination) is scheduled to depart at \(departureTime) from terminal \(departTerminal)")
            }
         
        case .delayed:
            var departureTime = "TBD"
            var departTerminal  = "TBD"
            if let time = flights.departureTime {
                departureTime = flightTime.string(from: time)
            }
            if let departTerminal = flights.terminal {
            print("Your flight to \(flights.destination) originally scheduled to depart at \(departureTime) from terminal: \(departTerminal) has been delayed. Please remain in the gate area for further notifications.")
            } else {
                    print("Your flight to \(flights.destination) has been delayed. Please contact a gate agent to obtain information on the new flight time and terminal.")
            }
            
        case .nowBoarding:
            if let terminal = flights.terminal {
                print("Your flight to \(flights.destination) is boarding, please head to terminal \(terminal) immediately. The doors are closing soon.")
            } else {
                print("Your flight to \(flights.destination) is boarding. Please make your way to the terminal identified on the airport screeens immediately. If you cannot locate the terminal, contact a gate agent for information.")
            }
        default:
            break
        }   //close switch
    }  // close for loop
  }   // close function
}  // close class
  

let torontoAirport = Airport(city: "Toronto", airportName: "Pearson", airportCode: "YYZ")
var torontoBoard = DepartureBoard(currentAirport: torontoAirport)


// Step 2 - I created 6 flights to allow for a more comprehensive test of the passenger alert func

let flightA = Flight(flightNumber: "AC4301", airline: "Air Canada", destination: "Calgary", departureTime: Calendar.current.date(from: DateComponents (year: 2020, month: 3, day: 17, hour: 22, minute: 35)), terminal: nil, status: FlightStatus.delayed)
let flightB  = Flight(flightNumber: "TK0006", airline: "Turkish Airlines", destination: "Istanbul", departureTime: Date(), terminal: "B", status: FlightStatus.nowBoarding)
let flightC = Flight(flightNumber: "UA1137", airline: "United Airlines", destination: "Chicago", departureTime: nil, terminal: "C", status: FlightStatus.canceled)
let flightD = Flight(flightNumber: "AA672", airline: "American Airlines", destination: "Paris", departureTime: Calendar.current.date(from: DateComponents (year: 2020, month: 3, day: 17, hour: 16, minute: 15)), terminal: nil, status: FlightStatus.ontime)
let flightE = Flight(flightNumber: "UA1555", airline: "United Airlines", destination: "London", departureTime: Date(), terminal: "C", status: FlightStatus.ontime)
let flightF = Flight(flightNumber: "TK1555", airline: "Turkish Airlines", destination: "Amsterdam", departureTime: Date(), terminal: nil, status: FlightStatus.nowBoarding)


torontoBoard.departures.append(flightA)
torontoBoard.departures.append(flightB)
torontoBoard.departures.append(flightC)
torontoBoard.departures.append(flightD)
torontoBoard.departures.append(flightE)
torontoBoard.departures.append(flightF)

//Step 3 and 4   I modified the original function as opposed to creating a new one again. Instructions said either option was acceptable


func printDepartures(departureBoard: DepartureBoard) {
    
    let flightTime = DateFormatter()
    flightTime.timeStyle = .short
    
    
    for currentBoard in departureBoard.departures {
       
        let flightnumber = currentBoard.flightNumber
        let airline = currentBoard.airline
        let destination = currentBoard.destination
        let terminal = currentBoard.terminal ?? "TBD"
        let status = currentBoard.status.rawValue
        var departTime = ""
        if let time = currentBoard.departureTime {
            departTime = flightTime.string(from: time)
        }
        
        
        let flightInfo = "Flight: \(flightnumber), Airline: \(airline), Destination: \(destination), Departure Time: \(departTime), Terminal: \(terminal), Status: \(status)"
        
        
        
        print(flightInfo)
        }
        }
    
printDepartures(departureBoard: torontoBoard)

torontoBoard.alertPassengers()

// Step 6

func calculateAirfare(checkedBags: Double, distance: Double, travelers: Double) -> String {
    
   let currency = NumberFormatter()
    currency.numberStyle = .currency
    currency.locale = Locale.current

    
    let distanceCost: Double = (0.1 * distance)
    let bagCost: Double = (25 * checkedBags)
    
    let totalAirfare: Double = (travelers * distanceCost) + bagCost
    
    let airFareCurrency = currency.string(from: NSNumber(value: totalAirfare))!   // Thank you XCode "fix" !!!
    return airFareCurrency
}

print (calculateAirfare(checkedBags: 3, distance: 1489.91, travelers: 2))
print (calculateAirfare(checkedBags: 1, distance: 6783.52, travelers: 1))
print (calculateAirfare(checkedBags: 7, distance: 4000.00,  travelers: 4))

