//
//  ApplicationView.swift
//  GoIntern
//
//  Created by Lee Juhyun on 4/11/25.
//

import SwiftData
import SwiftUI

struct ApplicationView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Application.deadline, order: .forward) var applications: [Application]
    @State private var showingNewApplicationSheet = false
    @State private var applicationToEdit: Application?

    var body: some View {
        NavigationStack {
            List(applications) { application in
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text(application.companyName)
                            .font(.headline)
                        Spacer()
                        Image(systemName: application.isComplete ? "checkmark.circle.fill" : "circle")
                            .foregroundColor(application.isComplete ? .blue : .gray)
                    }
                    Text(application.jobDescription)
                        .font(.subheadline)
                        .lineLimit(1)
                        .truncationMode(.tail)
                        .foregroundColor(.secondary)
                    
                    HStack(spacing: 8) {
                        StatusBadge(title: "Resume", status: application.resumeStatus)
                        StatusBadge(title: "Interview", status: application.interviewStatus)
                    }
                }
                .padding(.vertical, 8)
                .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                    Button {
                        modelContext.delete(application)
                    } label: {
                        Image(systemName: "trash")
                    }
                    .tint(.red)
                }
                .onTapGesture {
                    applicationToEdit = application
                }
            }
            .navigationTitle("Your Applications")
            .toolbar {
                Button {
                    showingNewApplicationSheet = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingNewApplicationSheet) {
                CreateApplicationView()
            }
            .sheet(item: $applicationToEdit, content: { application in
                UpdateApplicationView(application: application)
            })
            .overlay {
                if applications.isEmpty {
                    ApplicationUnavailableView()
                }
            }
        }
    }
}

struct StatusBadge: View {
    var title: String
    var status: Status
    
    var body: some View {
        HStack(spacing: 4) {
            Text(title)
                .font(.caption)
                .foregroundColor(.primary)
            Text(statusText)
                .font(.caption2)
                .padding(4)
                .background(statusColor.opacity(0.2))
                .foregroundColor(statusColor)
                .cornerRadius(4)
        }
    }
    
    var statusText: String {
        switch status {
        case .pending: return "Pending"
        case .accepted: return "Accepted"
        case .rejected: return "Rejected"
        }
    }
    
    var statusColor: Color {
        switch status {
        case .pending: return .gray
        case .accepted: return .green
        case .rejected: return .red
        }
    }
}

#Preview {
    ApplicationView()
}
