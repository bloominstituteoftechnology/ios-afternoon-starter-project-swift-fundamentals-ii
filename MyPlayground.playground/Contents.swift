 
// Enum - enumeration

enum AppleProducts: String {
    case iPhone
    case iPad
    case MacBook
    case watch = "Apple Watch"
}

print(AppleProducts.watch.rawValue)


enum PizzaCategory: String {
    case classic
    case specialty
    case glutenFree
}

let specialtyPizza = PizzaCategory.specialty
let myFavoritePizza: PizzaCategory = .classic

print(myFavoritePizza)


struct pizza {
    let name: String
    let cost: Double
    let category: PizzaCategory
}

let myPizza = pizza(name: "GIANT PIZZA", cost: 12.99, category: .classic)

print("I would like to order a \(myPizza.name)")
print(myPizza.cost)



class PizzaPlace {
    var name: String
    var adress: String
    var pizzas: [pizza]
    
    // create Initializer
    init(name: String, adress: String) {
        self.name = name
        self.adress = adress
        self.pizzas = []
        
    }
    func add(pizza: pizza) {
        pizzas.append(pizza)
        
    }
}

let mikeysPizzaPlace = PizzaPlace(name: "Mikey's Pizza", adress: "123 pizza rd")


// difference between value types and reference types


// struct = value type








// refernce types : Class

class City {
    var name: String
    var population: Int
    
    init(name: String, population: Int) {
        self.name = name
        self.population = population
        
    }
}

let rochester = City(name: "Rochester, NY", population: 208_000)

let roc = rochester
roc.name = "ROC"

print("rochester: \(rochester.name)")
print("roc: \(roc.name)")



func increasePopulation(city: City) {
    city.population = city.population + 1
}


struct Person {
    var name: String
    var age: Double
}

var me = Person(name: "Mikey", age: 27)

me.age = 28

print(me.age)


class Person2 {
    var name: String
    var age: Double
    
    init(name: String, age: Double) {
        self.name = name
        self.age = age
    }
}

let me2 = Person2(name: "mikey", age: 27)

me2.age = 28
print(me2.age)


class Vacuum {
    var isOn: Bool
    var isPluggedIn: Bool
    var rugHeight: Int
    var isSelfDrviving: Bool
    var attachments: [String]
    
    init(isSelfDriving: Bool = false, attachments: [String] = [] ) {
        self.isOn = false
        self.isPluggedIn = false
        self.rugHeight = 5
        self.isSelfDrviving = isSelfDriving
        self.attachments = attachments
    }
}


let sharkVacuum = Vacuum(isSelfDriving: false, attachments: ["Dusting Brush", "Crevice Brush"])

let roombaVacuum = Vacuum(isSelfDriving: true)

print(roombaVacuum.attachments)



// Optionals

// if your work is close and your dont have a car
var myCar: String? = nil
 // i changed jobs and now i do have a car

myCar = "Subaru"

// i get into an accident

myCar = nil

// i got insurance money to get another car

myCar = "Telsa"

// i have 4 kids and have to get rid of my telsa

myCar = " toyota sienna"

// if let statement to unwrap an optional value
let subtotalString = "58.95"

if let subtotal = Double(subtotalString) {
    let tip = subtotal * 0.20
    let total = subtotal + tip
    print("Total: \(total)\n\tsubtotal:\(subtotal)\n\ttip: \(tip)")
} else { print("\(subtotalString) is not a valid amount")
}


let yearsOld: Int? = 35


if yearsOld != nil {
    let approximateDaysOld = 365 * yearsOld!
    print("Wow! You are \(approximateDaysOld) days old!")
}

if let yearsOld = yearsOld {
    let approximateDaysOld = 365 * yearsOld
    print("Wow! You are \(approximateDaysOld) days old!")
} else {
    print(" you dont have an age ")
}
