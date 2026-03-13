//
//  ContentView.swift
//  Units
//
//  Created by Dallas Johnson on 3/3/26.
//

import SwiftUI

struct ContentView: View {
    let unitTypes = ["Length", "Time", "Mass", "Temperature"]
    @State private var selectedUnitType = "Length"
    
    let unitsForType: [String: [String]] = [
        "Length": ["centimeters", "meters", "kilometers", "inches", "feet", "miles"],
        "Time": ["seconds", "minutes", "hours", "days"],
        "Mass": ["grams", "kilograms", "ounces", "pounds"],
        "Temperature": ["celsius", "fahrenheit", "kelvin"]
    ]
    @State private var selectedFromUnitForType: [String: String] = [
        "Length": "centimeters",
        "Time": "seconds",
        "Mass": "grams",
        "Temperature": "celsius"
    ]
    @State private var selectedToUnitForType: [String: String] = [
        "Length": "centimeters",
        "Time": "seconds",
        "Mass": "grams",
        "Temperature": "celsius"
    ]
    
    let ratiosForType: [String: [Double]] = [
        "Length": [1, 100, 100000, 2.54, 30.48, 160934],
        "Time": [1, 60, 3600, 86400],
        "Mass": [1, 1000, 28.3495, 453.592],
        "Temperature": [1, 0.555555555, 1]
    ]
    let offsetsForType: [String: [Double]] = [
        "Length": [0, 0, 0, 0, 0, 0],
        "Time": [0, 0, 0, 0],
        "Mass": [0, 0, 0, 0],
        "Temperature": [0, 32, 273.15]
    ]
    
    @State private var inputValue: Double = 0
    private var outputValue: Double {
        let fromUnitIdx = unitsForType[selectedUnitType]!.firstIndex(of: selectedFromUnitForType[selectedUnitType]!)!
        let fromRatio = ratiosForType[selectedUnitType]![fromUnitIdx]
        let fromOffset = offsetsForType[selectedUnitType]![fromUnitIdx]
        
        let toUnitIdx = unitsForType[selectedUnitType]!.firstIndex(of: selectedToUnitForType[selectedUnitType]!)!
        let toRatio = ratiosForType[selectedUnitType]![toUnitIdx]
        let toOffset = offsetsForType[selectedUnitType]![toUnitIdx]
        
        let offsetFromVal = inputValue - fromOffset
        let convertedVal = (offsetFromVal * fromRatio) / toRatio
        let convertedOffsetVal = convertedVal + toOffset
        
        return convertedOffsetVal
    }
    
    @FocusState private var editingInput: Bool
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Picker("Unit category", selection: $selectedUnitType) {
                        ForEach(unitTypes, id: \.self) {
                            Text($0)
                        }
                    }
                    Picker("From", selection: Binding($selectedFromUnitForType[selectedUnitType])!) {
                        ForEach(unitsForType[selectedUnitType]!, id: \.self) {
                            Text($0)
                        }
                    }
                    Picker("To", selection: Binding($selectedToUnitForType[selectedUnitType])!) {
                        ForEach(unitsForType[selectedUnitType]!, id: \.self) {
                            Text($0)
                        }
                    }
                }
                
                Section("Input") {
                    TextField("Enter value", value: $inputValue, format: .number)
                }
                .focused($editingInput)
                
                Section("Result") {
                    Text(outputValue, format: .number)
                }
            }
            .navigationTitle("Unit Converter")
#if !os(macOS)
            .toolbar {
                if editingInput {
                    Button("Done") {
                        editingInput = false
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
