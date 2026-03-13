//
//  ContentView.swift
//  WordScramble
//
//  Created by Dallas Johnson on 3/10/26.
//

import SwiftUI

func hasSpellingError(_ word: String) -> Bool {
#if os(iOS)
    let checker = UITextChecker()
    let range = NSRange(location: 0, length: word.utf16.count) // Explicitly declare encoding
    let misspelledRange = checker.rangeOfMisspelledWord(
        in: word,
        range: range,
        startingAt: 0,
        wrap: false,
        language: "en"
    )
    return misspelledRange.location != NSNotFound
#elseif os(macOS)
    let checker = NSSpellChecker.shared
    let range = checker.checkSpelling(of: word, startingAt: 0)
    return range.location != NSNotFound
#endif
}

struct LearningContentView: View {
    // String tokenization
    static let input = "a b c"
    let letters = input.components(separatedBy: " ")
    
    // Whitespace trimming
    static let input2 = "   hello world   "
    let trimmed = input2.trimmingCharacters(in: .whitespacesAndNewlines)
    
    // Spell check
    static let word = "swift"
    #if os(iOS)
    static let checker = UITextChecker()
    static let range = NSRange(location: 0, length: word.utf16.count) // Explicitly declare encoding
    static let misspelledRange = checker.rangeOfMisspelledWord(
        in: word,
        range: range,
        startingAt: 0,
        wrap: false,
        language: "en"
    )
    let mistakeFound = misspelledRange.location == NSNotFound
    #elseif os(macOS)
    static let checker = NSSpellChecker.shared
    static let range = checker.checkSpelling(of: word, startingAt: 0)
    let mistakeFound =  range.location == NSNotFound
    #endif
    
    var body: some View {
        List {
            Section("Section 1") {
                Text("Static row 1")
                Text("Static row 2")
            }

            Section("Section 2") {
                ForEach(0..<5) {
                    Text("Dynamic row \($0)")
                }
            }

            Section("Section 3") {
                Text("Static row 3")
                Text("Static row 4")
            }
        }
#if !os(macOS)
        .listStyle(.grouped)
#endif
        
        // Dynamic list shortcut
        List(0..<5) {
            Text("Dynamic row \($0)")
        }
        
    }
}

struct ContentView: View {
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    
    @State private var score = 0
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                List {
                    Section {
                        TextField("Enter your word", text: $newWord)
    #if os(iOS)
                            .textInputAutocapitalization(.never)
    #endif
                    }

                    Section {
                        ForEach(usedWords.reversed(), id: \.self) { word in
                            HStack {
                                Image(systemName: "\(word.count).circle")
                                Text(word)
                            }
                        }
                    }
                }
                
                VStack {
                    Spacer()
                    Button("Score: \(score)") {}
                        .font(.largeTitle)
                        .buttonStyle(.glass)
                        .foregroundColor(.secondary)
                }
            }
            .onAppear(perform: startGame)
            .toolbar {
                Button("Restart", action: startGame)
            }
            .onSubmit(addNewWord)
            .alert(errorTitle, isPresented: $showingError) { } message: {
                Text(errorMessage)
            }
            .navigationTitle(rootWord)
        }
    }
    
    func startGame() {
        usedWords.removeAll()
        score = 0
        
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL, encoding: .utf8) {
                let allWords = startWords.components(separatedBy: "\n")
                
                rootWord = allWords.randomElement() ?? "apricorn"
                return
            }
        }
        
        fatalError("Could not load starting words from bundle!")
    }
    
    func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
    
        // Disallow empty strings
        if (answer.count == 0) {
            return;
        }
        
        // Disallow used words
        if (answer == rootWord || usedWords.contains(answer)) {
            errorTitle = "Word has already been used!"
            errorMessage = "Try again."
            showingError = true
            return;
        }
        
        // Disallow words that can't be created from the letters of the root word
        var tempWord = rootWord
        for letter in answer {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            }
            else {
                errorTitle = "Impossible word!"
                errorMessage = "All words must be made with the letters in the root word. Try again."
                showingError = true
                return
            }
        }
        
        // Disallow misspelled words
        if (hasSpellingError(answer)) {
            errorTitle = "Misspelled word!"
            errorMessage = "All words must be valid english words in Apple's dictionary. Try again."
            showingError = true
            return
        }
        
        withAnimation {
            usedWords.append(answer)
            score += answer.count
        }
        newWord = ""
    }
}

#Preview {
    ContentView()
}
