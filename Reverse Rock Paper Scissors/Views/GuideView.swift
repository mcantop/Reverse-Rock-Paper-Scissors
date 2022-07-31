//
//  GuideView.swift
//  Reverse Rock Paper Scissors
//
//  Created by Maciej on 31/07/2022.
//

import SwiftUI

struct GuideView: View {
    var body: some View {
        VStack(spacing: 30) {
            HStack {
                Text("Guide")
                Spacer()
            }
            .font(.system(size: 30, weight: .bold, design: .rounded))
            .padding()
            .background(.ultraThinMaterial)
            
            VStack {
                Text("How to play?")
            }
            .font(.system(size: 20, design: .rounded))
            .padding()
            .background(.ultraThinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
            .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 10)
            
            VStack {
                VStack(spacing: 20) {
                    Text("AI randomly chooses one move:")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("🪨 🧻 ✂️")
                        .frame(maxWidth: .infinity, alignment: .center)
                    Text("It has to either win or lose.")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("You are supposed to select the correct option to match the AI's choice and whether it is supposed to win or lose.")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("AI chooses ✂️ and it has to lose.")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("The correct answer is 🪨.")
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .font(.system(size: 20, design: .rounded))
                .padding()
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 10)
            }
            .padding(.leading, 20)
            .padding(.trailing, 20)
            Spacer()
            
        }
    }
}

struct GuideView_Previews: PreviewProvider {
    static var previews: some View {
        GuideView()
    }
}
