//
//  CreateApplicationView.swift
//  GoIntern
//
//  Created by Lee Juhyun on 4/11/25.
//

import SwiftData
import SwiftUI

struct CreateApplicationView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    @FocusState private var titleFocus: Bool
    @State private var companyName: String = ""
    @State private var isComplete = false
    @State private var newDeadline: Date = .now
    @State private var newLink: String = ""
    @State private var resumeStatus: Status = .pending
    @State private var interviewStatus: Status = .pending
    @State private var jobDescription: String = ""
    
    var body: some View {
        NavigationStack {
            Form {
                Section("COMPANY DETAILS") {
                    TextField("Company", text: $companyName)
                        .focused($titleFocus)
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                titleFocus = true
                            }
                        }
                    Toggle(isOn: $isComplete) {
                        Label(isComplete ? "Completed" : "Incomplete", systemImage: isComplete ? "checkmark.circle.fill" : "circle")
                    }
                    DatePicker("Deadline", selection: $newDeadline, displayedComponents: .date)
                    TextField("Link", text: $newLink)
                }
                Section("STATUS") {
                    VStack(alignment: .leading) {
                        Text("Resume Status")
                            .font(.headline)
                            .foregroundColor(.indigo)
                        Picker("Resume", selection: $resumeStatus) {
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
                        Picker("Interview", selection: $interviewStatus) {
                            Text("Pending").tag(Status.pending)
                            Text("Accepted").tag(Status.accepted)
                            Text("Rejected").tag(Status.rejected)
                        }
                        .pickerStyle(.segmented)
                        .disabled(resumeStatus != .accepted)
                    }
                }
                Section("JOB DESCRIPTION") {
                    VStack(alignment: .leading) {
                        TextEditor(text: $jobDescription)
                            .frame(height: 120)
                            .padding(4)
                    }
                }
            }
            .navigationTitle("New Application")
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
                        let application = Application(companyName: companyName, deadline: newDeadline, isComplete: isComplete, resumeStatus: resumeStatus, interviewStatus: interviewStatus, jobDescription: jobDescription, link: newLink)
                        print("app for \(application.companyName)added")
                        modelContext.insert(application)
                        dismiss()
                    }, label: {
                        Text("Save")
                    }).disabled(
                        companyName.isEmpty
                    )
                }
            }
        }
    }
}

#Preview {
    CreateApplicationView()
}
