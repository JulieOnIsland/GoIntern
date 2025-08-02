//
//  ApplicationUnavailableView.swift
//  GoIntern
//
//  Created by Lee Juhyun on 4/11/25.
//

import SwiftUI

struct ApplicationUnavailableView: View {
    var body: some View {
        VStack {
            Image(systemName: "list.clipboard")
                .resizable()
                .scaledToFit()
                .frame(width: 120, height: 100)
                .foregroundStyle(.gray)

            Text("No Applications")
                .font(.title)
                .fontWeight(.bold)

            Text("Press the + button to create one.")
                .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    ApplicationUnavailableView()
}
