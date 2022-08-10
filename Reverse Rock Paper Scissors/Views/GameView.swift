//
//  GameView.swift
//  Reverse Rock Paper Scissors
//
//  Created by Maciej on 29/07/2022.
//

import SwiftUI

struct GameView: View {
    @EnvironmentObject var game: Game
    @State private var lastRoundHistory = [String]()
    @State private var endGameState = false

    var body: some View {
        ZStack {
            EmojisBackground()
            
            VStack(spacing: 30) {
                HStack {
                    Text("Logic Game")
                    Spacer()
                    Text("Score: ")
                        .font(.system(size: 20, design: .rounded)) +
                    Text("\(game.userScore)")
                        .font(.system(size: 20, design: .rounded))
                        .foregroundColor(game.roundResult == "Correct" ? .green : (game.roundResult == "Wrong" ? .red : .primary))
                }
                .font(.system(size: 30, weight: .bold, design: .rounded))
                .padding()
                .background(.ultraThinMaterial)
                
                HStack {
                    Text("Round \(game.questionNumber)/\(Int(game.totalQuestionNumber))")
                }
                .font(.system(size: 20, design: .rounded))
                .padding()
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 10)
                
                VStack {
                    Text("AI chooses ") +
                    Text("\(game.aiMoves[game.winningMove])")
                        .font(.title3.weight(.bold))
                    + Text(" and has to ") +
                    Text(game.aiWin == true ? "win" : "lose")
                        .font(.title3.weight(.bold))
                    + Text(".")
                    HStack(spacing: 15) {
                        ForEach(game.aiMoves, id: \.self) { move in
                            Text(move)
                                .font(.system(size: 60))
                                .padding(15)
                                .background(
                                    game.aiMoves.firstIndex(of: move) == game.winningMove ? ( game.aiWin == true ? .green.opacity(0.6) :  .red.opacity(0.5) ) : .white.opacity(0.0)
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
                        ForEach(game.userMoves, id: \.self) { move in
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
                Button("Restart") { game.restartGame() }
            } message: {
                Text("You got \(game.userScore) points.")
            }
        }
    }
    
    
    func roundCheck(playerMove: String) {
        let aiMove = game.aiMoves[game.winningMove]
        
        switch (aiMove, game.aiWin, playerMove) {
        case
            ("🪨", true, "✂️"),
            ("🪨", false, "✂️"),
            ("✂️", false, "🧻"),
            ("✂️", false, "🪨"),
            ("✂️", true, "🧻"),
            ("🪨", false, "🧻"),
            ("🧻", false, "✂️"),
            ("🧻", true, "🪨"):
            withAnimation { game.userScore += 1 }
            game.roundResult = "Correct"
        default:
            withAnimation { game.userScore -= 1 }
            game.roundResult = "Wrong"
        }
        
        lastRoundHistory.append("\(game.questionNumber):")
        lastRoundHistory.append(aiMove)
        lastRoundHistory.append(game.aiWin == true ? "AI Win" : "AI Lose")
        lastRoundHistory.append(playerMove)
        lastRoundHistory.append(game.roundResult)
        game.history.append(lastRoundHistory)
        lastRoundHistory = [String]()
        
        game.aiWin.toggle()
        game.questionNumber += 1
        if game.questionNumber == Int(game.totalQuestionNumber + 1) {
            game.questionNumber = Int(game.totalQuestionNumber)
            endGameState = true
        } else {
            withAnimation {
                game.winningMove = Int.random(in: 0...2)
                game.aiMoves.shuffle()
                game.userMoves.shuffle()
            }
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
            .environmentObject(Game())
    }
}
