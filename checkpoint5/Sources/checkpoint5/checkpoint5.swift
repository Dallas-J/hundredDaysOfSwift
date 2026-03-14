// The Swift Programming Language
// https://docs.swift.org/swift-book

@main
struct checkpoint5 {
    static func greet() {
        print("Hi!")
    }

    static func dallasSort(a: String, b: String) -> Bool {
        if (a == "Dallas") {
            return true
        } else if (b == "Dallas") {
            return false
        }

        return a < b
    }

    static func main() {
        let firstGreet = greet
        firstGreet()
        print()

        let greetName = { (name: String) -> String in
            return "Good morning \(name)!"
        }
        print(greetName("Sarah")) // Closures don't require parameter names
        print()

        let names = ["Toby", "Alex", "Ryan", "Dallas"]
        print(names.sorted())
        print(names.sorted(by: dallasSort))
        // Trailing closure syntax + hidden return syntax
        print(names.sorted { $0 > $1 })
        print(names.filter { $0.hasPrefix("T") })
        print(names.map { $0 + " is cool" }) // Ooh la la
        print()

        // checkpoint 5 code
        let luckyNumbers = [7, 4, 38, 21, 16, 15, 12, 33, 31, 49]
        let luckyStrs = luckyNumbers.filter{ $0 % 2 != 0 }.sorted().map{ "\($0) is a lucky number" }
        for str in luckyStrs {
            print(str)
        }
    }
}
