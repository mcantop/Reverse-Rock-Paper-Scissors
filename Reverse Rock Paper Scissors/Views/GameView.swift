//
//  GameView.swift
//  Reverse Rock Paper Scissors
//
//  Created by Maciej on 29/07/2022.
//

import SwiftUI

struct GameView: View {
    @EnvironmentObject var player: PlayerInfo
    @State private var lastHistory = [String]()
    @State private var size: CGFloat = 0.5
    @State private var winningMove = Int.random(in: 0...2)
    @State private var restartGameState = false
    @State private var endGameState = false
    @State private var aiWin = false
    @State private var aiMoves = ["🪨", "🧻", "✂️"]
    @State private var playerMoves = ["🪨", "🧻", "✂️"].shuffled()
    
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
            
            VStack(spacing: 30) {
                HStack {
                    Text("Logic Game")
                    Spacer()
                    Button {
                        restartGameState = true
                    } label: {
                        Image(systemName: "arrow.triangle.2.circlepath.circle.fill")
                            .foregroundColor(.primary)
                    }
                    .font(.system(size: 30, design: .rounded))
                    .alert(isPresented: $restartGameState) {
                        Alert(
                            title: Text("Restart the game"),
                            message: Text("Are you sure you want to restart the game?"),
                            primaryButton: .destructive(Text("Restart")) {
                                restartGame()
                            },
                            secondaryButton: .cancel()
                        )
                    }
                    Spacer()
                    
                    Text("Score: ")
                        .font(.system(size: 20, design: .rounded))
                    +
                    Text("\(player.score)")
                        .font(.system(size: 20, design: .rounded))
                        .foregroundColor(player.result == "Correct" ? .green : (player.result == "Wrong" ? .red : .primary))
                }
                .font(.system(size: 30, weight: .bold, design: .rounded))
                .padding()
                .background(.ultraThinMaterial)
                
                HStack {
                    Text("Round \(player.question)/10")
                }
                .font(.system(size: 20, design: .rounded))
                .padding()
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 10)
                
                VStack {
                    Text("AI chooses \(aiMoves[winningMove]) and has to ") +
                    Text(aiWin == true ? "win" : "lose")
                        .font(.title2.weight(.bold))
                    + Text(".")
                    HStack(spacing: 15) {
                        ForEach(aiMoves, id: \.self) { move in
                            Text(move)
                                .font(.system(size: 60))
                                .padding(15)
                                .background(
                                    aiMoves.firstIndex(of: move) == winningMove ? ( aiWin == true ? .green.opacity(0.6) :  .red.opacity(0.5) ) : .white.opacity(0.0)
                                )
                                .cornerRadius(15)
                        }
                    }
                }
                .font(.system(size: 20, design: .rounded))
                .padding()
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 10)
                
                VStack {
                    Text("What do you choose?")
                    HStack(spacing: 15) {
                        ForEach(playerMoves, id: \.self) { move in
                            Button(move) {
                                roundCheck(playerMove: move)
                            }
                            .font(.system(size: 60))
                            .padding(15)
                            .background(.white.opacity(0.3))
                            .cornerRadius(15)
                        }
                    }
                }
                .font(.system(size: 20, design: .rounded))
                .padding()
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 10)
                
                Spacer()
                
            }
            .alert("Game Finished", isPresented: $endGameState) {
                Button("Restart") { restartGame() }
            } message: {
                Text("You got \(player.score) points.")
            }
        }
    }
    
    
    func roundCheck(playerMove: String) {
        let aiMove = aiMoves[winningMove]
        
        switch (aiMove, aiWin, playerMove) {
        case
            ("🪨", true, "✂️"),
            ("🪨", false, "✂️"),
            ("✂️", false, "🧻"),
            ("✂️", false, "🪨"),
            ("✂️", true, "🧻"),
            ("🪨", false, "🧻"),
            ("🧻", false, "✂️"),
            ("🧻", true, "🪨"):
            withAnimation { player.score += 1 }
            player.result = "Correct"
        default:
            withAnimation { player.score -= 1 }
            player.result = "Wrong"
        }
        
        lastHistory.append("\(player.question):")
        lastHistory.append(aiMove)
        lastHistory.append(aiWin == true ? "AI Win" : "AI Lose")
        lastHistory.append(playerMove)
        lastHistory.append(player.result)
        player.history.append(lastHistory)
        lastHistory = [String]()
        
        aiWin.toggle()
        player.question += 1
        if player.question == 11 {
            player.question = 10
            endGameState = true
        } else {
            
            withAnimation {
                winningMove = Int.random(in: 0...2)
                aiMoves.shuffle()
                playerMoves.shuffle()
            }
        }
    }
    
    func restartGame() {
        aiWin.toggle()
        player.history = [[String]]()
        player.result = ""
        withAnimation {
            player.score = 0
            player.question = 1
            winningMove = Int.random(in: 0...2)
            aiMoves = ["🪨", "🧻", "✂️"]
            playerMoves.shuffle()
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
            .environmentObject(PlayerInfo())
    }
}
