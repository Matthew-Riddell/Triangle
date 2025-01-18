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
                    HStack {
                        Spacer()
                        HStack(spacing: 16) {
                            NavigationLink(destination: DetailView(title: "Profile")) {
                                Text("Profile")
                            }
                            .buttonStyle(NavbarButton())
                            NavigationLink(destination: DetailView(title: "Settings")) {
                                Image(systemName: "gearshape.fill")
                                    .resizable()
                                    .frame(width: 24, height: 24)
                                
                            }
                            .buttonStyle(NavbarButton())
                        }
                        .padding(.horizontal, 20)
                    }
                    .padding(.top, 20)
                    
                    VStack(spacing: 40) {
                        ForEach(0..<2, id: \.self) { row in
                            HStack(spacing: 40) {
                                DashboardCard(title: "Social", imageNames: ["SocialTriangle"], destination: DetailView(title: "Social"), progress: 0.5)
                                DashboardCard(title: "Focus & Attention", imageNames: ["SocialTriangle"], destination: DetailView(title: "Focus & Attention"), progress: 0.3)
                            }
                            .frame(maxWidth: .infinity)
                        }
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
