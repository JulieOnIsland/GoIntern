//
//  ContentView.swift
//  GoIntern
//
//  Created by Lee Juhyun on 4/15/25.
//

import SwiftData
import SwiftUI
import WidgetKit

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var showingLinkedInSheet = false
    @State private var showingNewApplicationSheet = false
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 22) {
                Spacer()
                Text("Internship Dashboard")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .padding(.horizontal)
                Spacer()
                // Pie Chart Section
                PieChartView()
                    .frame(height: 300)
                    .padding()
                    .background(.background)
                    .cornerRadius(16)
                    .shadow(color: .black.opacity(0.05), radius: 6, x: 0, y: 2)
                    .padding(.horizontal)
                
                // Job Sites
                HStack(alignment: .center, spacing: 16) {
                    Spacer()
                    Link(destination: URL(string: "https://unc.joinhandshake.com/explore")!) {
                        VStack(spacing: 8) {
                            Image(.handshake)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
//                                .clipShape(Circle())
                        }
                        .frame(width: 60, height: 60)
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 2)
                    }
                    Spacer()
                    Link(destination: URL(string: "https://www.linkedin.com")!) {
                        VStack(spacing: 8) {
                            Image(.linkedin)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
//                                .clipShape(Circle())
                        }
                        .frame(width: 60, height: 60)
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 2)
                    }
                    Spacer()
                    Link(destination: URL(string: "https://www.indeed.com")!) {
                        VStack(spacing: 8) {
                            Image(.indeed)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
//                                .clipShape(Circle())
                        }
                        .frame(width: 60, height: 60)
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 2)
                    }
                    Spacer()
                }
                .padding(.horizontal)
                
                // Application & Messages
                VStack(spacing: 12) {
                    NavigationLink(destination: ApplicationView()) {
                        ActionCard(icon: "list.bullet", title: "View Applications", color: .blue)
                    }

                    NavigationLink(destination: LinkedInMessageListView()) {
                        ActionCard(icon: "message.badge", title: "View Messages", color: .pink)
                    }
                }
                .padding(.horizontal)
                Spacer()
            }
        }
        .task {
            let notifications = NotificationCenter.default.notifications(named: ModelContext.didSave)
            
            for await _ in notifications {
                WidgetCenter.shared.reloadAllTimelines()
            }
        }

        .sheet(isPresented: $showingNewApplicationSheet) {
            CreateApplicationView()
        }
        .sheet(isPresented: $showingLinkedInSheet) {
            LinkedInMessageCreateView()
        }
    }
}

struct ActionCard: View {
    var icon: String
    var title: String
    var color: Color
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(.white)
                .padding()
                .background(color)
                .clipShape(Circle())
            
            Text(title)
                .font(.headline)
                .foregroundColor(.primary)
            
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .padding()
        .background(.ultraThinMaterial)
        .cornerRadius(12)
    }
}

#Preview {
    ContentView()
        .modelContainer(for: [Application.self, Message.self], inMemory: true)
}
