//
//  ContentView.swift
//  Animations
//
//  Created by Dallas Johnson on 3/10/26.
//

import SwiftUI

struct CornerRotateModifier: ViewModifier {
    let amount: Double
    let anchor: UnitPoint

    func body(content: Content) -> some View {
        content
            .rotationEffect(.degrees(amount), anchor: anchor)
            .clipped()
    }
}

extension AnyTransition {
    static var pivot: AnyTransition {
        .modifier(
            active: CornerRotateModifier(amount: -90, anchor: .topLeading),
            identity: CornerRotateModifier(amount: 0, anchor: .topLeading)
        )
    }
}

struct ContentView: View {
    @State private var animationAmount = 1.0
    @State private var animation2 = 1.0
    @State private var infiniteAnimation = 1.0
    
    @State private var rotationAmount = 0.0
    
    @State private var enabled = true
    @State private var rounded = false
    
    @State private var dragAmount = CGSize.zero
    
    let letters = Array("Hello SwiftUI")
    @State private var letterDragPos = CGSize.zero

    
    var body: some View {
        ZStack {
            VStack {
                Button("Tap Me") {
                    animationAmount += 1
                }
                .padding(40)
                .background(.red)
                .foregroundStyle(.white)
                .clipShape(.circle)
                .scaleEffect(animationAmount)
                .blur(radius: (animationAmount - 1) * 3)
                // The stepper will still animate this button even with this animation commented out!
                //.animation(.spring(duration: 1, bounce: 0.7), value: animationAmount)
                
                Button("Tap Me") {
                    animation2 += 1
                }
                .padding(40)
                .background(.red)
                .foregroundStyle(.white)
                .clipShape(.circle)
                .scaleEffect(animation2)
                .blur(radius: (animation2 - 1) * 3)
                .animation(.easeInOut(duration: 2)
                    .repeatCount(3, autoreverses: true)
                    .delay(1), value: animation2)
                
                Button("Tap Me") {
                    withAnimation {
                        enabled.toggle()
                    }
                }
                .padding(40)
                .background(enabled ? .red : .blue)
                .foregroundStyle(.white)
                .clipShape(.circle)
                .overlay(
                    Circle()
                        .stroke(.red)
                        .scaleEffect(infiniteAnimation)
                        .opacity(2.6 - (infiniteAnimation * 2))
                        .animation(
                            .easeOut(duration: 1)
                                .repeatForever(autoreverses: false),
                            value: infiniteAnimation
                        )
                )
                .onAppear {
                    infiniteAnimation = 1.3
                }
                if (!enabled) {
                    Rectangle()
                        .fill(.blue)
                        .frame(width: 200, height: 200)
                        .transition(.asymmetric(insertion: .pivot, removal: .opacity))
                }
                
                Button("Tap Me") {
                    withAnimation(.spring(duration: 1, bounce: 0.5)) {
                        rotationAmount += 360
                        rounded.toggle()
                    }
                }
                .padding(40)
                .background(.red)
                .foregroundStyle(.white)
                .clipShape(.rect(cornerRadius: rounded ? 60 : 0))
                .rotation3DEffect(.degrees(rotationAmount), axis: (x: 0, y: 1, z: 0))
                
                LinearGradient(colors: [.yellow, .red], startPoint: .topLeading, endPoint: .bottomTrailing)
                    .frame(width: 200, height: 60)
                    .clipShape(.rect(cornerRadius: 10))
                    .offset(dragAmount)
                    .gesture(DragGesture()
                        .onChanged { dragAmount = $0.translation }
                        .onEnded { _ in
                            // Alternative to the below - this only animates the ending
                            withAnimation(.bouncy) {
                                dragAmount = .zero
                            }
                        }
                    )
                    // This would animate dragging, adding latency!
                    // .animation(.bouncy, value: dragAmount)
                
                HStack(spacing: 0) {
                            ForEach(0..<letters.count, id: \.self) { num in
                                Text(String(letters[num]))
                                    .padding(3)
                                    .font(.title)
                                    .offset(letterDragPos)
                                    .animation(.linear.delay(Double(num) / 20), value: letterDragPos)
                            }
                        }
                        .gesture(
                            DragGesture()
                                .onChanged { letterDragPos = $0.translation }
                                .onEnded { _ in letterDragPos = .zero }
                        )
            }
            
            VStack {
                Stepper("Scale amount", value: $animationAmount.animation(), in: 1...10)
                Spacer()
            }
        }
    }
}

#Preview {
    ContentView()
}
