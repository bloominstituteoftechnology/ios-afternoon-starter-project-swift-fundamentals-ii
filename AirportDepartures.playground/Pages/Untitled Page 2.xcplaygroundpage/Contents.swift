//: [Previous](@previous)

import Foundation
import UIKit

enum FlightStatus:String {
    case enRoute
    case scheduled
    case canceled
    case delayed
    case landed
    case onTime
}

let enRouteStatus: FlightStatus = .enRoute
let scheduledStatus: FlightStatus = .scheduled
let canceledStatus: FlightStatus = .canceled
let delayedStatus: FlightStatus = .delayed
let landedStatus: FlightStatus = .landed
let onTimeStatus: FlightStatus = .onTime


struct Airport {
    let destination: String
    let arrival: String
}

struct Flight {
    let date: Date?
    let terminal: String?
}

class DepartureBoard {
    var departure: String
    var currentAirport: String
    var airports: [Airport]
    
    init(departure: String, currentAirport: String) {
        self.departure = departure
        self.currentAirport = currentAirport
        airports = []
    }
    func add(airport: Airport) {
        airports.append(airport)
        
    }
    let departureTime = Date()
    let jFK = Flight(date: nil, terminal: "Terminal A")
    let jFK2 = DepartureBoard(departure: "JFK", currentAirport: "NRT" )
    let bTV = Flight(date: nil, terminal: "Terminal C")
    let bTV2 = DepartureBoard(departure: "JFK", currentAirport: "BVT")
    let yYZ = Flight(date: nil, terminal: nil)
    let yYZ2 = DepartureBoard(departure: "JFK", currentAirport: "YYZ")
}
//: [Next](@next)
