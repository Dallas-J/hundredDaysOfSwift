// The Swift Programming Language
// https://docs.swift.org/swift-book

@main
struct checkpoint3 {
    static func main() {
        let score = 80
        if score > 80 {
            print("You did it!")
        }
        else {
            print ("Too bad")
        }
        print()

        var username = ""
        if username.isEmpty {
            username = "Anon"
        }
        print(username)
        print()

        // Switch statements work on strings!
        let place = "LA"
        switch place {
            case "NY":
                print("Big apple")
            case "LA":
                print("Big car")
                fallthrough
            default:
                print("Big lotta nothing, that's what!")
        }
        print()

        let platforms = ["iOS", "macOS", "Windows", "Linux"]
        for os in platforms {
            print("Swift works on \(os)!")
        }
        print()

        for i in 1...12 {
            print("5 * \(i) = \(5 * i)")
        }
        print()

        var lyric = "Haters gonna"
        for _ in 1...5 {
            lyric += " hate"
        }
        print(lyric)
        print()

        let roll = Int.random(in: 1...20)
        print("I rolled \(roll)")
        print()

        // checkpoint 3 code
        for i in 1...100 {
            if i % 3 == 0 && i % 5 == 0 {
                print("FizzBuzz")
            }
            else if i % 3 == 0 {
                print("Fizz")
            }
            else if i % 5 == 0 {
                print("Buzz")
            }
            else {
                print(i)
            }
        }
    }
}
