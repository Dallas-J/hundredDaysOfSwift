// The Swift Programming Language
// https://docs.swift.org/swift-book

class Game {
    var score = 0 {
        didSet {
            print("Score is now \(score)")
        }
    }
    let players: Int

    init(players: Int) {
        self.players = players
    }

    deinit {
        print("Removing game. Final score: \(score)")
    }

    func isOver() -> Bool {
        return score >= 100
    }
}

class TennisGame: Game {
    override func isOver() -> Bool {
        return score >= 60
    }

    init() {
        super.init(players: 2)
    }
}

class VolleyballGame: Game {
    override func isOver() -> Bool {
        return score >= 25
    }

    init() {
        super.init(players: 12)
    }
}

// checkpoint 7 code
class Animal {
    var legs: Int

    init(legs: Int) {
        self.legs = legs
    }

    func speak() {}
}

class Dog: Animal {
    init() {
        super.init(legs: 4)
    }

    override func speak() {
        print("Woof!")
    }
}

class Corgi: Dog {
    override func speak() {
        print("Borf")
    }
}

class Poodle: Dog {
    override func speak() {
        print("arf arf")
    }
}

class Cat: Animal {
    var isTame: Bool
    
    init(isTame: Bool) {
        self.isTame = isTame
        super.init(legs: 4)
    }

    override func speak() {
        print("Meow")
    }
}

class Persian: Cat {
    override func speak() {
        print("mrrrow")
    }
}

class Lion: Cat {
    override func speak() {
        print("ROAR!")
    }
}

@main
struct checkpoint7 {
    static func main() {
        let one = Game(players: 4)
        one.score += 10
        let two = Game(players: 2)
        two.score += 10
        let twoCopy = two
        twoCopy.score += 10
        print()

        one.score = 100
        print(one.isOver())
        let three = TennisGame()
        three.score = 80
        print(three.isOver())
        print()

        // checkpoint 7 code
        let animals = [ Cat(isTame: true), Dog(), Persian(isTame: true), Poodle(), Corgi(), Lion(isTame: false) ]
        for a in animals {
            a.speak()
        }
    }
}
