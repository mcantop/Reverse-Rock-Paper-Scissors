//
//  ContentView.swift
//  Reverse Rock Paper Scissors
//
//  Created by Maciej on 25/07/2022.
//

import SwiftUI

class PlayerInfo: ObservableObject {
    @Published var history = [[String]]()
    @Published var score = Int()
    @Published var result = String()
    @Published var question = 1
}

struct ContentView: View {
    @StateObject var player = PlayerInfo()
    
    var body: some View {
        
        TabView {
            GameView()
                .environmentObject(player)
                .tabItem {
                    Label("Logic Game", systemImage: "gamecontroller")
                }
            
            HistoryView()
                .environmentObject(player)
                .tabItem {
                    Label("History", systemImage: "archivebox.fill")
                }
                .badge(player.question - 1)
        }
        .tabViewStyle(selectedItemColor: .primary, badgeColor: .secondary)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
