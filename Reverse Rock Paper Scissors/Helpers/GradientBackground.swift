//
//  GradientBackground.swift
//  Reverse Rock Paper Scissors
//
//  Created by Maciej on 01/08/2022.
//

import SwiftUI

struct GradientBackground: View {
    var body: some View {
        ZStack {
            LinearGradient(colors: [Color.gray.opacity(0.6), Color.gray.opacity(0.9)], startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
        }
    }
}

struct GradientBackground_Previews: PreviewProvider {
    static var previews: some View {
        GradientBackground()
    }
}
