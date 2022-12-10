//
//  LostPetWidget.swift
//  LostPetWidget
//
//  Created by Erdem Inmez on 2022-12-10.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    
    
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date())
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
}

struct WeatherWidgetEntryView : View {
    @EnvironmentObject var fireDBHelper : FireDBHelper
    
    var entry: Provider.Entry

    var body: some View {
        ZStack(alignment: .center) {
            VStack {
                Spacer()
                Text("\(self.fireDBHelper.disappearanceAlertList[0].petType)")
                Spacer()
                Text("\(self.fireDBHelper.disappearanceAlertList[0].dspCity)")
                Spacer()
                Text("\(self.fireDBHelper.disappearanceAlertList[0].dspCountry)")
                Spacer()
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .center)
        }
        .onAppear(){
            self.fireDBHelper.getAllAlerts()
        }
    }
}

@main
struct WeatherWidget: Widget {
    let kind: String = "com.ei.Lost-Pet-Alert-App-V2.LostPetWidget"
    
    let fireDBHelper : FireDBHelper
    
    init() {
        FirebaseApp.configure()
        fireDBHelper = FireDBHelper(database: Firestore.firestore())
    }

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            LostPetWidgetEntryView(entry: entry)
                .environmentObject(fireDBHelper)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

struct WeatherWidget_Previews: PreviewProvider {
    static var previews: some View {
        WeatherWidgetEntryView(entry: SimpleEntry(date: Date()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
