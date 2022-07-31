//
//  ContentView.swift
//  Reverse Rock Paper Scissors
//
//  Created by Maciej on 25/07/2022.
//

import SwiftUI

class Game: ObservableObject {
    @Published var history = [[String]]()
    @Published var userScore = Int()
    @Published var roundResult = String()
    @Published var questionNumber = 1
    @Published var totalQuestionNumber = 10.0
    @Published var aiWin = false
    @Published var winningMove = Int.random(in: 0...2)
    @Published var aiMoves = ["🪨", "🧻", "✂️"]
    @Published var userMoves = ["🪨", "🧻", "✂️"].shuffled()
    
    func restartGame() {
        aiWin.toggle()
        history = [[String]]()
        roundResult = ""
        withAnimation {
            userScore = 0
            questionNumber = 1
            winningMove = Int.random(in: 0...2)
            aiMoves = ["🪨", "🧻", "✂️"]
            userMoves.shuffle()
        }
    }
}

struct ContentView: View {
    @StateObject var game = Game()
    
    var body: some View {
        ZStack {            
            TabView {
                GameView()
                    .tabItem {
                        Label("Play", systemImage: "gamecontroller")
                    }
                    .background(EmojisBackground())

                HistoryView()
                    .tabItem {
                        Label("History", systemImage: "archivebox.fill")
                    }
                    .background(GradientBackground())
                    .badge(game.questionNumber - 1)
                
                GuideView()
                    .tabItem {
                        Label("Guide", systemImage: "book")
                    }
                    .background(GradientBackground())
                
                SettingsView()
                    .tabItem {
                        Label("Settings", systemImage: "gearshape.fill")
                    }
                    .background(GradientBackground())
            }
            .environmentObject(game)
            .tabViewStyle(selectedItemColor: .primary, badgeColor: .secondary)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
