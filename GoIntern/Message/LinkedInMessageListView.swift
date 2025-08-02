//
//  LinkedInMessageListView.swift
//  GoIntern
//
//  Created by Lee Juhyun on 4/12/25.
//

import SwiftData
import SwiftUI

struct LinkedInMessageListView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Message.createdDate, order: .forward) var messages: [Message]
    @State private var showingMessageCreateSheet = false
    
    var body: some View {
        NavigationStack {
            List(messages) { message in
                VStack(alignment: .leading) {
                    Text(message.content)
                        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                            Button {
                                modelContext.delete(message)
                            } label: {
                                Image(systemName: "trash")
                            }
                            .tint(.red)
                        }
                        .padding(.bottom, 5)
                    Text("\(message.createdDate.formatted(.relative(presentation: .numeric)))")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }

            .navigationTitle("Your Message")
            .toolbar {
                Button {
                    showingMessageCreateSheet = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            
            .sheet(isPresented: $showingMessageCreateSheet) {
                LinkedInMessageCreateView()
            }
            .overlay {
                if messages.isEmpty {
                    MessageUnavailableView()
                }
            }
        }
    }
}

#Preview {
    LinkedInMessageListView()
}
