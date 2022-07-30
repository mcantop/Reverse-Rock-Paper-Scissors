//
//  ContentView.swift
//  Reverse Rock Paper Scissors
//
//  Created by Maciej on 25/07/2022.
//

import SwiftUI

class PlayerInfo: ObservableObject {
    @Published var score = Int()
    @Published var result = String()
}

class OperationHistory: ObservableObject {
    @Published var array = [[String]]()
}

struct ContentView: View {
    @StateObject var history = OperationHistory()
    @StateObject var player = PlayerInfo()
    
    var body: some View {
        TabView {
            GameView()
                .environmentObject(history)
                .environmentObject(player)
                .tabItem {
                    Label("Game", systemImage: "gamecontroller")
                }
            
            HistoryView()
                .environmentObject(history)
                .environmentObject(player)
                .tabItem {
                    Label("History", systemImage: "archivebox.fill")
                }
//                .badge(10)
        }
        .tabViewStyle(selectedItemColor: .primary, badgeColor: .red)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
