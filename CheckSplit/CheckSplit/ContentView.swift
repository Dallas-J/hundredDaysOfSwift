//
//  ContentView.swift
//  CheckSplit
//
//  Created by Dallas Johnson on 3/1/26.
//

import SwiftUI

struct LearningContentView: View {
    @State private var tapCount = 0
    @State private var name = ""
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Text("Hello world!")
                }
                Section {
                    Text("Hello \(name)!")
                    TextField("Enter name", text: $name)
                }
                Button("Tap Count: \(tapCount)") {
                    tapCount += 1
                }
                ForEach(0..<10, id: \.self) { i in
                    Text("Item \(i)")
                }
            }
            .navigationTitle("CheckSplit")
        }
    }
}

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 15
    @FocusState private var editingAmount: Bool
    
    let tipPercentages = [0, 10, 15, 18, 22]
    
    var totalPerPerson: Double {
        let percentIncludingTip = 1.0 + (Double(tipPercentage) / 100)
        return (checkAmount * percentIncludingTip) / Double(numberOfPeople)
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Amount and people") {
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .focused($editingAmount)
#if !os(macOS)
                        .keyboardType(.decimalPad)
#endif
                    
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<100, id: \.self) {
                            Text("\($0) people")
                        }
                    }
#if !os(macOS)
                    .pickerStyle(.navigationLink)
#endif
                }
                
                Section("Tip percentage") {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section("Total per person") {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
            }
            .navigationTitle("CheckSplit")
#if !os(macOS)
            .toolbar {
                if editingAmount {
                    Button("Done") {
                        editingAmount = false
                    }
                }
            }
#endif
        }
    }
}

#Preview {
    ContentView()
}
