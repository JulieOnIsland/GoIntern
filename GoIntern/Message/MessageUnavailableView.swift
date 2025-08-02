//
//  MessageUnavailableView.swift
//  GoIntern
//
//  Created by Lee Juhyun on 4/14/25.
//

import SwiftUI

struct MessageUnavailableView: View {
    var body: some View {
        VStack {
            Image(systemName: "ellipsis.message")
                .resizable()
                .scaledToFit()
                .frame(width: 120, height: 100)
                .foregroundStyle(.gray)

            Text("No Message Yet")
                .font(.title)
                .fontWeight(.bold)

            Text("Press the + button to create one.")
                .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    MessageUnavailableView()
}
