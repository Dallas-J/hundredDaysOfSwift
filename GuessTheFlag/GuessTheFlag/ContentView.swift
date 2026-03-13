//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Dallas Johnson on 3/4/26.
//

import SwiftUI

extension UnitPoint {
    /// - returns: The point on the perimeter of the unit square that is at angle `angle` relative to the center of the unit square.
    init(_ angle: Angle) {
        // Inspired by https://math.stackexchange.com/a/4041510/399217
        // Also see https://www.desmos.com/calculator/k13553cbgk

        let s = sin(angle.radians)
        let c = cos(angle.radians)
        self.init(
            x: (c / s).clamped(to: -1...1) * copysign(1, s) * 0.5 + 0.5,
            y: (s / c).clamped(to: -1...1) * copysign(1, c) * 0.5 + 0.5
        )
    }
}


extension Comparable {
    /// - returns: The nearest value to `self` that is in `range`.
    func clamped(to range: ClosedRange<Self>) -> Self {
        return max(range.lowerBound, min(self, range.upperBound))
    }
}

struct LearningContentView: View {
    @State private var showingAlert = false
    var body: some View {
        Form{
            Section("VStack") {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Hello, world!")
                    Text("This is inside a stack")
                }
            }
            
            Section("HStack") {
                HStack(spacing: 20) {
                    Spacer()
                    Text("Hello, world!")
                    Text("This is inside a stack")
                    Spacer()
                }
            }
            
            Section("ZStack") {
                ZStack {
                    Text("Hello, world!")
                    Text("This is inside a stack")
                }
            }
            
            Section("Colors") {
                ZStack {
                    VStack {
                        LinearGradient(colors: [.green, .clear, .red], startPoint: .top, endPoint: .bottom)
                            .frame(height: 100)
                        RadialGradient(colors: [.blue, .green, .cyan], center: .center, startRadius: 20, endRadius: 200)
                            .frame(height: 50)
                        AngularGradient(stops: [
                            .init(color: .primary, location: 0),
                            .init(color: .yellow, location: 0.2),
                            .init(color: .red, location: 0.5)
                        ], center: .center)
                            .frame(height: 200)
                    }
                    VStack {
                        Text("Your content")
                            .background(.background)
                            .foregroundColor(.primary)
                        Text("Content 2")
                            .background(.mint.gradient) // not sure what this does
                            .foregroundColor(.white)
                        Text("Content 3")
                            .foregroundStyle(.secondary)
                            .padding(50)
                            .background(.ultraThinMaterial)
                    }
                }
            }
            
            Section("Buttons") {
                Button("Delete section", role: .destructive, action: { print("Deleting...") })
                Button("Button 2", role: .confirm, action: { print("Confirming...") })
                    .buttonStyle(.bordered)
                Button("Button 3", role: .cancel, action: { print("Cancelling...") })
                    .buttonStyle(.borderedProminent)
                    .tint(Color(.mint))
                Button {
                    print("Button was tapped")
                } label: {
                    Text("Tap me!")
                        .padding()
                        .foregroundStyle(.white)
                        .background(.red.opacity(0.5))
                }
                Button("Edit", systemImage: "pencil") {
                    print("Edit button was tapped")
                }
                Button("Show Alert") {
                    showingAlert = true
                }
                .alert("Important message", isPresented: $showingAlert) {
                    Button("Delete", role: .destructive) { }
                    Button("Cancel", role: .cancel) { }
                } message: {
                    Text("all the info you need...")
                }
            }
        }
        .ignoresSafeArea(edges: .all) // Start render at screen top and fill to bottom
    }
}

struct ContentView: View {
    @State private var showingScore = false
    @State private var showingEnd = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var round = 1
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(stops: [
                    .init(color: .blue, location: 0),
                    .init(color: .green, location: 0.4),
                    .init(color: .init(red: 0.8, green: 0.8, blue: 0.9), location: 1.0)
                ], startPoint: .init(.init(degrees: 90)), endPoint: .init(.init(degrees: 0)))
                    .ignoresSafeArea(edges: .all)
                
                VStack(spacing: 15) {
                    Text("Tap the flag of \(countries[correctAnswer])!")
                        .font(.system(size: 18))
                                        
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: 280)
                        }
                        .cornerRadius(4)
                        .shadow(radius: 2)
                    }
                    
                    Text("Score: \(score)")
                        .foregroundStyle(.secondary)
                        .font(.title.bold())
                        .padding(.top, 5)
                }
                .padding(20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 24))
            }
            .alert(scoreTitle, isPresented: $showingScore) {
                Button("Continue", action: askQuestion)
            } message: {
                Text("Your score is \(score).")
            }
            .alert("Good job! Play again?", isPresented: $showingEnd) {
                Button("Replay", action: { score = 0; round = 1; askQuestion() })
            } message: {
                Text("Your final score was \(score) out of 8.")
            }
            .navigationTitle("Guess the Flag")
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            score += 1
            scoreTitle = "Correct!!!"
        } else {
            scoreTitle = "Wrong, that's \(countries[number])!"
        }
        
        round += 1
        if (round > 8) {
            showingEnd = true
        }
        else {
            showingScore = true
        }
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

#Preview {
    ContentView()
}
