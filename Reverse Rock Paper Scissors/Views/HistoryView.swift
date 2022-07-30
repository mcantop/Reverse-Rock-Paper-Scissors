//
//  HistoryView.swift
//  Reverse Rock Paper Scissors
//
//  Created by Maciej on 29/07/2022.
//

import SwiftUI

struct HistoryView: View {
    @EnvironmentObject var history: OperationHistory
    @EnvironmentObject var player: PlayerInfo
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [Color.gray.opacity(0.6), Color.gray.opacity(0.9)], startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            
                VStack(spacing: 30) {
                    HStack {
                        Text("History")
                        
                        Spacer()
                        Text("Score: ")
                            .font(.system(size: 20, design: .rounded)) +
                        Text("\(player.score)")
                            .font(.system(size: 20, design: .rounded))
                            .foregroundColor(player.result == "Correct" ? .green : (player.result == "Wrong" ? .red : .primary))
                    }
                    .font(.system(size: 30, weight: .bold, design: .rounded))
                    .padding()
                    .background(.ultraThinMaterial)
                    
                    if history.array.isEmpty {
                        Text("No history yet.")
                            .font(.system(size: 20, design: .rounded))
                            .padding()
                            .background(.ultraThinMaterial)
                            .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                            .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 10)
                    }
                    
                    VStack {
                    ForEach(history.array.reversed(), id: \.self) { array in
                        HStack(spacing: 20) {
                            ForEach(array, id: \.self) {
                                Text($0)
                                    .foregroundColor($0 == "Correct" ? .green : ($0 == "Wrong" ? .red : .primary))
                            }
                        }
                        .font(.system(size: 20, design: .rounded))
                        .padding()
                        .background(.ultraThinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                        .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 10)
                    }
                    
                    Spacer()
                    }
                }
        }
    }
}

//struct HistoryView_Previews: PreviewProvider {
//    static var previews: some View {
//        HistoryView()
//    }
//}
