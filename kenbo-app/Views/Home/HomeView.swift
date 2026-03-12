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
                
                // Health Bar
                StatBarCard(
                    title: "Health",
                    icon: "heart-pulse",
                    current: 200,
                    max: 300,
                    color: Color(hex: "FE7171"),
                    lightColor: Color(hex: "FFC5C5"),
                    outerCircleColor: Color(hex: "9C3B3B"),
                    unit: "HP"
                )
                
                // Power Bar
                StatBarCard(
                    title: "Power",
                    icon: "food-turkey",
                    current: 200,
                    max: 300,
                    color: Color(hex: "6EE46C"),
                    lightColor: Color(hex: "B5F2B4"),
                    outerCircleColor: Color(hex: "3D8D3B"),
                    unit: "PW"
                )
                
                // Stamina Bar
                StatBarCard(
                    title: "Stamina",
                    icon: "energy",
                    current: 200,
                    max: 300,
                    color: Color(hex: "D5E5FF"),
                    lightColor: Color(hex: "D5E5FF"),
                    outerCircleColor: Color(hex: "385382"),
                    unit: "ST"
                )
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
