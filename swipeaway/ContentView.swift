//
//  ContentView.swift
//  swipeaway
//
//  Created by Anish Alle on 1/28/26.
//

import SwiftUI
import AuthenticationServices

var authManager = AuthManager()

struct ContentView: View {
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Image(.swipeawayWhite)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 70)
                Text("swipeaway")
                    .font(.title)
                    .bold()
                Spacer()
            }
            .frame(maxHeight: .infinity, alignment: .center)
            Spacer()
            Button(action: {authManager.runAuth()}) {
                //TODO: fix this thing changing to black in light mode
                Text("Sign in with Bungie")
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
            }
                .padding(.bottom, 40)
                .buttonStyle(.glass)
                
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(LinearGradient(
            gradient:
                Gradient(colors: [.gradientstart, .gradientend]),
            startPoint: .bottomLeading, endPoint: .topTrailing))
    }
}


#Preview {
    ContentView()
}
