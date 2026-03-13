import Cocoa

var username: String? = nil

if let username = username {
    print("Hello, \(username)!")
}
else {
    print("No name")
}

// Alternative way to unwrap optional
//guard let username = username else {
//    print("No name")
//    fatalError("No name")
//}

let name = username ?? "Anonymous"
print(name)

let names = ["Dallas", "Ryan", "Toby"]
let chosen = names.randomElement()?.uppercased() ?? "None"
print("I choose \(chosen).")

// Super clean error handling
enum DiceError: Error {
    case noRoll
}
func rollDice() throws -> Int {
    throw DiceError.noRoll
}

if let roll = try? rollDice() {
    print("Rolled a \(roll)")
}
else {
    print("An error occurred.")
}

print("Rolled a \((try? rollDice()) ?? -1)")

// checkpoint 9 code
func random(from numbers: [Int]?) -> Int {
    return numbers?.randomElement() ?? (1...100).randomElement()!
}

print(random(from: nil))
print(random(from: [1,2,8,10]))
