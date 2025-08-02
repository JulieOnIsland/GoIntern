//
//  GoInternWidget.swift
//  GoInternWidget
//
//  Created by Lee Juhyun on 4/24/25.
//

import SwiftData
import SwiftUI
import WidgetKit

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), emoji: "😀")
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> Void) {
        let entry = SimpleEntry(date: Date(), emoji: "😀")
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> Void) {
        let entry = SimpleEntry(date: Date(), emoji: "🙂")
        
        let timeline = Timeline(entries: [entry], policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let emoji: String
}

struct GoInternWidgetEntryView: View {
    @Query(
        filter: #Predicate<Application> { !$0.isComplete },
        sort: \Application.deadline, order: .forward
    ) var applications: [Application]
    var entry: Provider.Entry

    var body: some View {
        let top3 = applications
            .filter { $0.deadline > Date.now }
            .prefix(3)
   
        if top3.isEmpty {
            VStack {
                Text("No Items")
                    .fontWeight(.bold)
                    .foregroundStyle(.red)
                
                Text("In the app, press '+' to add one.")
                    .font(.callout)
                    .fontWeight(.semibold)
                    .foregroundStyle(.secondary)
            }
            .containerBackground(.background.tertiary, for: .widget)
        } else {
            ForEach(top3) { top3App in
                HStack(alignment: .top, spacing: 8) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(top3App.companyName)
                            .font(.subheadline.bold())
                        
                        Text(top3App.deadline, style: .relative)
                            .font(.caption)
                    }
                    
                    Spacer()
                    
                    Image(systemName: "briefcase.fill")
                }
            }
            .foregroundStyle(.white)
            .containerBackground(.blue.gradient, for: .widget)
        }
    }
}

struct GoInternWidget: Widget {
    let kind: String = "GoInternWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            GoInternWidgetEntryView(entry: entry)
                .modelContainer(for: [Application.self, Message.self])
        }
        .configurationDisplayName("GoIntern Widget")
        .description("View the most recent applications")
    }
}

#Preview(as: .systemSmall) {
    GoInternWidget()
} timeline: {
    SimpleEntry(date: .now, emoji: "😀")
    SimpleEntry(date: .now, emoji: "🤩")
}
