//
//  HomeView.swift
//  kenbo-app
//
//  Created by Raihan Zhaky Al Hafizh on 11/03/26.
//


import SwiftUI

struct HomeView: View {
    let userName: String
    let gender: String
    @State private var statBars: [StatBarData] = StatBarData.defaultBars
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Profile Card
                ProfileCard(
                    userName: userName,
                    gender: gender,
                    currentXP: 180,
                    maxXP: 300,
                    completedTasks: 4,
                    totalTasks: 7
                )
                .padding(.top, 20)
                
                // Stat Bars
                ForEach(statBars) { stat in
                    StatBarCard(
                        title: stat.title,
                        icon: stat.icon,
                        current: stat.current,
                        max: stat.max,
                        color: stat.color,
                        lightColor: stat.lightColor,
                        outerCircleColor: stat.outerCircleColor,
                        unit: stat.unit
                    )
                }
            }
            .padding(.horizontal)
            .padding(.bottom, 20)
        }
        .background(Color(hex: "F7F7F7"))
        .ignoresSafeArea(edges: .bottom)
    }
}

#Preview {
    HomeView(userName: "Funday", gender: "Lelaki")
}
