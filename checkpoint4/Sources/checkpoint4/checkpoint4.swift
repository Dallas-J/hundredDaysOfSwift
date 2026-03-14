// The Swift Programming Language
// https://docs.swift.org/swift-book

@main
struct checkpoint4 {
    static func rollDice() -> Int {
        return Int.random(in: 1...20)
    }

    static func rollTwoDice() -> (roll1: Int, roll2: Int) {
        return (rollDice(), rollDice())
    }

    static func isTaylor(_ string: String) -> Bool {
        return string == "Taylor"
    }

    static func rollDice(sides n: Int, times: Int = 1) -> Int {
        var result = 0
        for _ in 1...times {
            result += Int.random(in: 1...n)
        }

        return result
    }

    enum PasswordError : Error {
        case short, long, easy
    }

    static func checkPassword(_ password: String) throws {
        if (password.count < 5) {
            throw PasswordError.short
        }
        if (password.count > 20) {
            throw PasswordError.long
        }
        if (password == "1234") {
            throw PasswordError.easy
        }
    }

    // checkpoint 4 code
    enum SqrtError: Error {
        case outOfBounds, noRoot
    }

    static func sqrt(_ n: Int) throws -> Int {
        if n < 1 || n > 10000 {
            throw SqrtError.outOfBounds
        }

        for i in 1...100 {
            if i * i == n {
                return i
            }
        }

        throw SqrtError.noRoot
    }

    static func main() {
        print(5.squareRoot())
        print(rollDice())
        print()

        let dict = [
            "Taylor": "Swift"
        ]
        print(dict["Taylor", default: "Who?"])
        print(isTaylor("Taylor"))
        print()

        let twoRolls = rollTwoDice()
        print("First: \(twoRolls.roll1), second: \(twoRolls.roll2)")
        print("First again: \(twoRolls.0)")
        let (first, _) = rollTwoDice()
        print("Next: \(first)")
        print()
        
        print(rollDice(sides: 100))
        print(rollDice(sides: 100, times: 10))
        print()

        do {
            try checkPassword("1234")
        } catch PasswordError.short {
            print("Password too short")
        } catch {
            print("Encountered an error")
        }
        print()

        // checkpoint 4 code
        do {
            try print(sqrt(100))
            try print(sqrt(1))
            try print(sqrt(25))
            try print(sqrt(5))
            try print(sqrt(999999))
        } catch SqrtError.noRoot {
            print("Error: no root")
        } catch SqrtError.outOfBounds {
            print("Error: out of bounds")
        } catch {
            print("Unknown error")
        }
    }
}
