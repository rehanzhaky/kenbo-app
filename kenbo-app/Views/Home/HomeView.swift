//
//  HomeView.swift
//  kenbo-app
//
//  Created by Raihan Zhaky Al Hafizh on 11/03/26.
//


import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack {
            Text("Hi, Kenbo User 👋")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
        }
    }
}

#Preview {
    HomeView()
}