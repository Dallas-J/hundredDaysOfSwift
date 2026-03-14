// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

@main
struct stringTest {
    static func main() {
        var str = "0"
        while true {
            str = str + str
            print("Running str.count for count=\(str.count)...")

            let start = Date.now
            for _ in 1...1000000 {
                var count = str.count
                count -= 1
            }
            let time = Date.now.timeIntervalSince(start)

            print("Took \(time) seconds.")
            print()
        }
    }
}
