//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Dallas Johnson on 3/7/26.
//

import SwiftUI

struct ContentView: View {
    let options = [ "Rock", "Paper", "Scissors" ]
    let winningSelection = [ 1, 2, 0 ]
    @State private var computerSelection = Int.random(in: 0..<3)
    
    @State private var numWins = 0
    @State private var numRounds = 0
    
    @State private var scoreTitle = ""
    @State private var scoreMessage = ""
    
    @State private var showingScore = false
    @State private var showingEnd = false
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Make your selection") {
                    Button("Rock", systemImage: "hammer.fill", action: { select(0) })
                    .foregroundStyle(Color.mint)
                    Button("Paper", systemImage: "document.fill", action: { select(1) })
                    .foregroundStyle(Color.cyan)
                    Button("Scissors", systemImage: "scissors", action: { select(2) })
                }
            }
            .alert(scoreTitle, isPresented: $showingScore) {
                Button("Continue", action: { computerSelection = Int.random(in: 0..<3) })
            } message: {
                Text(scoreMessage)
            }
            .alert("Good job! Play again?", isPresented: $showingEnd) {
                Button("Replay", action: { numWins = 0; numRounds = 0; computerSelection = Int.random(in: 0..<3) })
            } message: {
                Text("Your final score was \(numWins) out of \(numRounds).")
            }
            .navigationTitle("RockPaperScissors")
            .scrollDisabled(true)
        }
    }
    
    func select (_ index: Int) -> Void {
        numRounds += 1
        
        if (index == winningSelection[computerSelection]) {
            numWins += 1
            scoreTitle = "You win!"
            scoreMessage = "That's \(numWins) out of \(numRounds)."
        }
        else if (index == computerSelection) {
            scoreTitle = "Tie!"
            scoreMessage = "You are one with the machine. Try again!"
            numRounds -= 1
        }
        else {
            scoreTitle = "You lost!"
            scoreMessage = "Computer chose \(options[computerSelection]) - make sure to get revenge!"
        }
        
        // Either way, set up the next round
        if (numRounds == 10) {
            showingEnd = true
        }
        else {
            showingScore = true
        }
    }
}

#Preview {
    ContentView()
}
