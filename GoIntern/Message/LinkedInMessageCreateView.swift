//
//  LinkedInMessageCreateView.swift
//  GoIntern
//
//  Created by Lee Juhyun on 4/12/25.
//

import SwiftData
import SwiftUI

struct LinkedInMessageCreateView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    @FocusState private var messageFocus: Bool
    @State private var name: String = ""
    @State private var place: String = ""
    @State private var memo: String = ""
    @State private var responseText: String = ""
    let aiService = AIService()
    
    var body: some View {
        NavigationStack {
            Form {
                Section("DETAILS") {
                    TextField("What's the person's name?", text: $name)
                        .focused($messageFocus)
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                messageFocus = true
                            }
                        }
                    
                    TextField("Where did you meet him/her? (e.g. job fair)", text: $place)
                    TextField("Any thing you want to mention?", text: $memo)
                }
            }
            .navigationTitle("New Message")
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
                        Task {
                            let prompt = """
                            Name: \(name)
                            Place: \(place)
                            Note: \(memo)
                            """
                            responseText = await aiService.getAIResponse(prompt: prompt)
                            let message = Message(name: name, place: place, memo: memo, createdDate: Date.now, content: responseText)
                            modelContext.insert(message)
                            print(prompt)
                        }
                        
                        dismiss()
                    }, label: {
                        Text("Save")
                    }).disabled(
                        name.isEmpty || memo.isEmpty
                    )
                }
            }
        }
    }
}

#Preview {
    LinkedInMessageCreateView()
}
