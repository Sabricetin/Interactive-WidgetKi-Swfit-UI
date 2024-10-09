//
//  ToDoWidget.swift
//  ToDoWidget
//
//  Created by Sabri Çetin on 9.10.2024.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> ToDoEntry {
        ToDoEntry(toDoDisplay: Array(SharedDatas.shared.toDos.prefix(3)))
    }

    func getSnapshot(in context: Context, completion: @escaping (ToDoEntry) -> ()) {
       let entry = ToDoEntry(toDoDisplay: Array(SharedDatas.shared.toDos.prefix(3)))
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        
        let toDisplay = Array(SharedDatas.shared.toDos.prefix(3))

        let timeline = Timeline(entries: [ToDoEntry(toDoDisplay: toDisplay)], policy: .atEnd)
        completion(timeline)
    }
}

struct ToDoEntry: TimelineEntry {
    let date: Date = .now
    var toDoDisplay : [ToDo]
}

struct ToDoWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack {
           Text("ToDo Items")
            .fontWeight(.bold)
            .padding(.bottom , 5)
            
            VStack {
                if entry.toDoDisplay.isEmpty {
                    Text("Todos Completed")
                } else {
                    ForEach(entry.toDoDisplay) { ToDo in
                    
                        HStack {
                            Button(intent: CompleteToDoIntent(id: ToDo.id)) {
                                Image(systemName: ToDo.isDone ? "checkmark.circle.fill" : "circle")
                                    .foregroundColor(.purple)
                            } .buttonStyle(.plain)
                            
                            VStack(alignment: .leading) {
                                Text(ToDo.name)
                                    .textScale(.secondary)
                                    .lineLimit(1)
                                    .strikethrough(ToDo.isDone , pattern: .solid , color: .black)
                                Divider()
                            }
                            
                        }
                    }
                }
            }
            
        }
    }
}

struct ToDoWidget: Widget {
    let kind: String = "ToDoWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                ToDoWidgetEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                ToDoWidgetEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("ToDo Widget")
        .description("ToDo Widget with Interactions")
    }
}

#Preview(as: .systemSmall) {
    ToDoWidget()
} timeline: {
    ToDoEntry(toDoDisplay: Array(SharedDatas.shared.toDos.prefix(3)))
    ToDoEntry(toDoDisplay: Array(SharedDatas.shared.toDos.reversed().prefix(3)))
    }
