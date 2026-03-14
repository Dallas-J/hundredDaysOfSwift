// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

protocol Vehicle {
    func estimateTime(for distance: Int) -> Int
    func travel(distance: Int)
}

protocol HasStops {
    func considerStops(_ numStops: Int)
}

struct Car: Vehicle {
    func estimateTime(for distance: Int) -> Int {
        return distance / 50
    }

    func travel(distance: Int) {
        print("I'm driving \(distance)mi")
    }
}

struct Train: Vehicle, HasStops {
    func estimateTime(for distance: Int) -> Int {
        return distance / 70
    }

    func travel(distance: Int) {
        print("I'm riding for \(distance)mi")
    }

    func considerStops(_ numStops: Int) {
        if (numStops < 4) {
            print("\(numStops)! This is great!")
        }
        else if (numStops < 10) {
            print("Humming along")
        }
        else {
            print("I hate this!")
        }
    }
}

struct Plane: Vehicle, HasStops {
    func estimateTime(for distance: Int) -> Int {
        return distance / 200
    }

    func travel(distance: Int) {
        print("I'm flying \(distance)!")
    }

    func considerStops(_ numStops: Int) {
        if (numStops < 1) {
            print("\(numStops)! This is great!")
        }
        else if (numStops < 3) {
            print("Humming along")
        }
        else {
            print("I hate this!")
        }
    }
}

func getVehicle() -> any Vehicle {
    let rand = Int.random(in: 1...3)
    if (rand == 1) {
        return Car()
    }
    else if (rand == 2) {
        return Train()
    }
    else {
        return Plane()
    }
}

extension String {
    func trimmed() -> String {
        self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

extension Numeric {
    func squared() -> Self {
        return self * self
    }
}

// checkpoint 8 code
protocol Building {
    var rooms: Int { get }
    var cost: Int { get }
    var agent: String { get }
    func printSummary()
}

struct House: Building {
    var rooms: Int {
        get {
            return 5
        }
    }
    var cost: Int {
        get {
            return 50000
        }
    }
    var agent: String {
        get  {
            return "Henry"
        }
    }

    func printSummary() {
        print("This house has \(rooms) rooms, costs $\(cost), and is being sold by \(agent)")
    }
}

struct Office: Building {
    var rooms: Int {
        get {
            return 20
        }
    }
    var cost: Int {
        get {
            return 1200000
        }
    }
    var agent: String {
        get  {
            return "June"
        }
    }

    func printSummary() {
        print("This house has \(rooms) rooms, costs $\(cost), and is being sold by \(agent)")
    }
}

@main
struct checkpoint8 {
    static func main() {
        let vehicles: [any Vehicle] = [ Car(), Train(), Plane() ]
        for v in vehicles {
            print(v.estimateTime(for: 500))
            v.travel(distance: 500)

            if let vStop = v as? HasStops {
                vStop.considerStops(2)
            }
        }

        let homogenousVehicles: [some Vehicle] = [ Car(), Car() ]
        print(homogenousVehicles)
        print()

        let str = "  hello  "
        print(str)
        print(str.trimmed())
        print(5.squared())
        print()

        // checkpoint 8 code
        let buildings: [any Building] = [ House(), Office() ]
        for b in buildings {
            b.printSummary()
        }
    }
}
