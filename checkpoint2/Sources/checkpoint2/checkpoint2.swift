// The Swift Programming Language
// https://docs.swift.org/swift-book

enum Weekday {
    case monday
    case tuesday
    case wednesday
    case thursday
    case friday
}

@main
struct checkpoint2 {
    static func main() {
        let arr1 = ["Hello", "World"]
        print(arr1)
        print()

        var arr2 = [String]()
        arr2.append("good")
        arr2.append("day")
        arr2.insert("friggin", at: 1)
        print(arr2)
        print()

        print(arr2.contains("friggin"))
        arr2.remove(at: 1)
        print(arr2.contains("friggin"))
        print(arr2)
        print()

        print(arr2.reversed())
        print(arr2.sorted())
        print(arr2[0].sorted())
        print(arr1.reversed().reversed())
        print()

        let dict = [
            1: "one",
            2: "two",
            3: "three"
        ]
        print(dict)
        print()

        let set = Set(["one", "one", "two", "three"])
        print(set)
        print()

        var day = Weekday.monday
        print(day)
        switch day {
            case .monday:
                print("Happy day")
            case .tuesday, .wednesday:
                print("O happy day")
            default:
                print("what a day")
        }
        day = .friday
        print(day)
        print()

        // Explicit types
        let cities: [String] // This is a constant, but can be initialized later
        let score: Double = 0
        let day2: Weekday = .tuesday
        cities = ["LA"] // Note: this initializes cities, but cities.append() would _modify_ it before initialization, which is illegal

        // checkpoint 2 code
        let arrOfStrings = ["haha", "hoho", "hehe", "haha", "hooh"]
        print("Number of values in array: \(arrOfStrings.count)")
        print("Number of unique values in array: \(Set(arrOfStrings).count)")
    }
}
