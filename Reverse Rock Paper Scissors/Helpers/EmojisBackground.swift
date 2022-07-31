//
//  EmojisBackground.swift
//  Reverse Rock Paper Scissors
//
//  Created by Maciej on 01/08/2022.
//

import SwiftUI

struct EmojisBackground: View {
    @State private var size: CGFloat = 0.5

    private var repeatingAnimation: Animation {
        Animation
            .easeInOut(duration: 20)
            .repeatForever()
    }
    
    var body: some View {
        ZStack {
        LinearGradient(colors: [Color.gray.opacity(0.6), Color.gray.opacity(0.9)], startPoint: .topLeading, endPoint: .bottomTrailing)
            .ignoresSafeArea()
        
        Text("🪨")
            .font(.system(size: 200))
            .rotationEffect(.degrees(400))
            .offset(x: -200, y: -400)
            .blur(radius: 15)
            .scaleEffect(size)
            .onAppear() {
                withAnimation(self.repeatingAnimation) { self.size = 1.1 }
            }
        
        Text("🧻")
            .font(.system(size: 200))
            .rotationEffect(.degrees(220))
            .offset(x: 200, y: 100)
            .blur(radius: 15)
            .scaleEffect(size)
            .onAppear() {
                withAnimation(self.repeatingAnimation) { self.size = 1.1 }
            }
        
        Text("✂️")
            .font(.system(size: 200))
            .rotationEffect(.degrees(220))
            .offset(x: -250, y: 450)
            .blur(radius: 15)
            .scaleEffect(size)
            .onAppear() {
                withAnimation(self.repeatingAnimation) { self.size = 1.1 }
            }
        }
    }
}

struct EmojisBackground_Previews: PreviewProvider {
    static var previews: some View {
        EmojisBackground()
    }
}
