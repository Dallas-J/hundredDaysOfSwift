// The Swift Programming Language
// https://docs.swift.org/swift-book

@main
struct checkpoint6 {
    enum Personality: String {
        case fun = "fun"
        case outgoing = "outgoing"
        case miserable = "miserable"
        case lame = "lame"
        case cool = "cool"
    }
    
    struct Person {
        let name: String
        var age: Int
        var personality = Personality.lame
        private(set) var money = 0
        var bookedVacation = 0
        var availableVacation = 15 {
            willSet { print("Setting availableVacation...") }
            didSet { print("Set availableVacation from \(oldValue) to \(availableVacation)") }
            // These could notify external observers, ooh la la
        }
        var remainingVacation: Int { // Computed property with getter and setter
            get { availableVacation - bookedVacation }
            set { availableVacation = bookedVacation + newValue }
            
        }
        var summary: String { "\(name), age: \(age), is a \(personality.rawValue) person" }

        // Requires `mutating` because Swift tries to make all unmarked functions const when creating a const instance of the struct
        mutating func birthday() { age += 1 }
        mutating func earn(_ amount: Int) { money += amount }
    }

    // checkpoint 6 code
    struct Car {
        let make: String
        let model: String
        let totalSeats: Int
        private(set) var foldedSeats = 0
        var availableSeats: Int { totalSeats - foldedSeats }
        private(set) var gear = 0

        mutating func foldSeats(_ n: Int) {
            foldedSeats = min(totalSeats, foldedSeats + n)
        }
        mutating func unfoldSeats(_ n: Int) {
            foldedSeats = max(0, foldedSeats - n)
        }

        mutating func shift(into: String) {
            switch into {
                case "Reverse":
                    gear = -1
                case "First":
                    gear = 1
                case "Second":
                    gear = 2
                case "Third":
                    gear = 3
                case "Fourth":
                    gear = 4
                case "Neutral":
                    fallthrough
                default:
                    gear = 0
            }
        }
    }

    static func main() {
        var p1 = Person(name: "Joe Blow", age: 20)
        print(p1)
        print(p1.summary)
        print()

        print(p1.remainingVacation)
        p1.bookedVacation += 3
        p1.remainingVacation = 5
        print(p1.remainingVacation)
        print(p1.availableVacation)
        print()

        print(p1.money)
        // p1.money += 20 // Syntax error
        p1.earn(20)
        print(p1.money)
        print()

        // checkpoint 6 code
        var myCar = Car(make: "Volkswagen", model: "Passat", totalSeats: 5)
        myCar.foldSeats(10)
        print(myCar.availableSeats)
        myCar.unfoldSeats(2)
        print(myCar.availableSeats)
        myCar.shift(into: "Reverse")
        print(myCar.gear)
    }
}
