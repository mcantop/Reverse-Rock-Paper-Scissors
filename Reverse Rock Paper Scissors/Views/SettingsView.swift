//
//  SettingsView.swift
//  Reverse Rock Paper Scissors
//
//  Created by Maciej on 31/07/2022.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var player: Game
    @State private var isEditing = false
    @State private var restartGameState = false
    
    var body: some View {
        ZStack {
            GradientBackground()
            
            VStack(spacing: 30) {
                HStack {
                    Text("Settings")
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
                                player.restartGame()
                            },
                            secondaryButton: .cancel()
                        )
                    }
                }
                .font(.system(size: 30, weight: .bold, design: .rounded))
                .padding()
                .background(.ultraThinMaterial)
                
                VStack {
                    VStack {
                        Text("Questions: \(Int(player.totalQuestionNumber))")
                        Slider(
                            value: $player.totalQuestionNumber,
                            in: 5...15,
                            step: 1
                        ) {
                            Text("Number of questions")
                        } minimumValueLabel: {
                            Text("5")
                        } maximumValueLabel: {
                            Text("15")
                        } onEditingChanged: { editing in
                            isEditing = editing
                            if player.questionNumber != 1 {
                                player.restartGame()
                            }
                        }
                        
                    }
                    .font(.system(size: 20, design: .rounded))
                    .padding()
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                    .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 10)
                    
                    Spacer()
                }
                .padding(.trailing, 20)
                .padding(.leading, 20)
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(Game())
    }
}
