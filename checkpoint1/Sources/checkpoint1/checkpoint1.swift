// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

@main
struct checkpoint1 {
    static func main() {
        let message = "Hello world!"
        print(message)
        print(message.count)
        print(message.uppercased())
        print(message.hasPrefix("Hello"))
        print(message.hasSuffix(".jpg"))
        print()
        print(120.isMultiple(of: 3))
        var bool = true;
        print(bool.toggle())
        print(bool)
        print("the world is \(bool)")

        // checkpoint code
        let celsius = 12.6
        let fahrenheit = (celsius * (9 / 5)) + 32.0
        print(String(format: "Celsius is %.1f", celsius))
        print(String(format: "Fahrenheit is %.1f", fahrenheit))
    }
}
