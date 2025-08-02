//
//  PieChartView.swift
//  GoIntern
//
//  Created by Lee Juhyun on 4/16/25.
//

import Charts
import SwiftData
import SwiftUI

struct PieChartView: View {
    @Query var applications: [Application]
    
    struct ChartItem: Identifiable {
        let id = UUID()
        let category: String
        let count: Int
    }
    
    var chartData: [ChartItem] {
        var counts: [String: Int] = [:]

        let total = applications.count
        let completeApps = applications.filter { $0.isComplete }
        let incompleteCount = total - completeApps.count
        counts["Incomplete"] = incompleteCount

        let resumePending = completeApps.filter { $0.resumeStatus == .pending }.count
        let resumeRejected = completeApps.filter { $0.resumeStatus == .rejected }.count
        let resumeAccepted = completeApps.filter { $0.resumeStatus == .accepted }

        counts["Resume Pending"] = resumePending
        counts["Resume Rejected"] = resumeRejected

        let interviewPending = resumeAccepted.filter { $0.interviewStatus == .pending }.count
        let interviewRejected = resumeAccepted.filter { $0.interviewStatus == .rejected }.count
        let interviewAccepted = resumeAccepted.filter { $0.interviewStatus == .accepted }.count

        counts["Interview Pending"] = interviewPending
        counts["Interview Rejected"] = interviewRejected
        counts["Interview Accepted"] = interviewAccepted

        return counts.map { ChartItem(category: $0.key, count: $0.value) }.sorted { $0.count > $1.count }
    }
    
    var body: some View {
        NavigationStack {
            Chart(chartData) { item in
                SectorMark(
                    angle: .value("Applications", item.count),
                    innerRadius: .ratio(0.6),
                    angularInset: 1.5
                )
                .foregroundStyle(by: .value("Status", item.category))
                .cornerRadius(4)
            }
            .frame(width: 300, height: 300)
            .chartLegend(position: .bottom, alignment: .center, spacing: 20)
        }
        .padding()
    }
}

// #Preview {
//    PieChartView()
// }
