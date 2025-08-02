//
//  UpdateApplicationView.swift
//  GoIntern
//
//  Created by Lee Juhyun on 4/13/25.
//

import SwiftData
import SwiftUI

struct UpdateApplicationView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) private var dismiss
    @FocusState private var titleFocus: Bool
    @Bindable var application: Application
    
    var body: some View {
        NavigationStack {
            Form {
                Section("COMPANY DETAILS") {
                    TextField("Company", text: $application.companyName)
                        .focused($titleFocus)
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                titleFocus = true
                            }
                        }
                    Toggle(isOn: $application.isComplete) {
                        Label(application.isComplete ? "Completed" : "Incomplete", systemImage: application.isComplete ? "checkmark.circle.fill" : "circle")
                    }
                    DatePicker("Deadline", selection: $application.deadline, displayedComponents: .date)
                    TextField("Link", text: $application.link)
                }
                Section("STATUS") {
                    VStack(alignment: .leading) {
                        Text("Resume Status")
                            .font(.headline)
                            .foregroundColor(.indigo)
                        Picker("Resume", selection: $application.resumeStatus) {
                            Text("Pending").tag(Status.pending)
                            Text("Accepted").tag(Status.accepted)
                            Text("Rejected").tag(Status.rejected)
                        }
                        .pickerStyle(.segmented)
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Interview Status")
                            .font(.headline)
                            .foregroundColor(.orange)
                        Picker("Interview", selection: $application.interviewStatus) {
                            Text("Pending").tag(Status.pending)
                            Text("Accepted").tag(Status.accepted)
                            Text("Rejected").tag(Status.rejected)
                        }
                        .pickerStyle(.segmented)
                        .disabled(application.resumeStatus != .accepted)
                    }
                }
                Section("JOB DESCRIPTION") {
                    VStack(alignment: .leading) {
                        TextEditor(text: $application.jobDescription)
                            .frame(height: 120)
                            .padding(4)
                    }
                }
            }
            .navigationTitle("Application")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        dismiss()
                    }, label: {
                        Text("Cancel")
                    })
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        dismiss()
                    }, label: {
                        Text("Update")
                    })
                }
            }
        }
    }
}

#Preview {
//    UpdateApplicationView()
}
