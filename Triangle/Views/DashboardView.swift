//
//  ContentView.swift
//  Triangle
//
//  Created by Josef Zemlicka on 02.01.2025.
//

import SwiftUI

struct DashboardView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    Navbar()
                    VStack(spacing: 40) {
                        Grid(horizontalSpacing: 40, verticalSpacing: 40) {
                            GridRow {
                                DashboardCard(
                                    title: "Social",
                                    imageNames: ["SocialTriangle"],
                                    destination: HexagonView(
                                        exerciseId: 1, currentLevelIndex: 3),
                                    progress: 0.5)
                                DashboardCard(
                                    title: "Focus & Attention",
                                    imageNames: ["SocialTriangle"],
                                    destination: HexagonView(
                                        exerciseId: 2, currentLevelIndex: 3),
                                    progress: 0.3)
                            }
                            GridRow {
                                DashboardCard(
                                    title: "Social",
                                    imageNames: ["SocialTriangle"],
                                    destination: HexagonView(
                                        exerciseId: 3, currentLevelIndex: 3),
                                    progress: 0.5)
                                DashboardCard(
                                    title: "Focus & Attention",
                                    imageNames: ["SocialTriangle"],
                                    destination: HexagonView(
                                        exerciseId: 4, currentLevelIndex: 3),
                                    progress: 0.3)
                            }
                        }
                        .frame(maxWidth: .infinity)
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 20)
                }
                .padding()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(hex: 0xB5CFE3))
            .edgesIgnoringSafeArea(.all)
        }
    }
}

struct DetailView: View {
    let title: String

    var body: some View {
        VStack {
            Text("You are in the " + title + " view!")
        }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
            .previewInterfaceOrientation(.landscapeLeft)
            .previewDevice("iPad Pro 11-inch")
    }
}
