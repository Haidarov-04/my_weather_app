//
//  weather_widjet.swift
//  weather_widjet
//
//  Created by Haidarov N on 1/14/25.
//

import WidgetKit
import SwiftUI
import Alamofire

struct Provider: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), city: "Unknown", temperature: "0.0", icon: " ")
    }
    
    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry {
        SimpleEntry(date: Date(), city: "Unknown", temperature: "0.0", icon: " ")
    }
    
    //    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
    //        var entries: [SimpleEntry] = []
    //
    ////        var watherData: WeatherData?
    //
    //        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
    //           let urlString = "https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline/khujand?unitGroup=metric&key=HEJT94MTK3HHYMJBYYPAUA2DD&contentType=json"
    ////
    //           AF.request(urlString, method: .get).responseDecodable(of: WeatherDatas.self){ response in
    //               switch response.result {
    //               case .success(let data):
    //                   print(data)
    //                   entries.append(SimpleEntry(date: Date(), city: data.address, temperature: data.currentConditions.temp, icon: data.currentConditions.icon))
    //                   WidgetCenter.shared.reloadAllTimelines()
    //               case .failure(let error):
    //                   print("Error: \(error.localizedDescription)")
    //
    //               }
    //
    //           }
    //
    //
    //        return Timeline(entries: entries, policy: .atEnd)
    //    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
        let currentDate = Date()
        var entries: [SimpleEntry] = []
        
        if let userDefaults = UserDefaults(suiteName: "group.haidarovs.weather.app") {
            let city = userDefaults.string(forKey: "city") ?? "Unknown City"
            let temp = userDefaults.string(forKey: "temp") ?? "0.0"
            let icon = userDefaults.string(forKey: "icon") ?? "default_icon"
            let validEntry = SimpleEntry(
                date: currentDate,
                city: city,
                temperature: temp,
                icon: icon
            )
            entries.append(validEntry)
        }
        
        if entries.isEmpty {
            let fallbackEntry = SimpleEntry(
                date: currentDate,
                city: "Error",
                temperature: "0.0",
                icon: "error"
            )
            entries.append(fallbackEntry)
        }
        return Timeline(entries: entries, policy: .atEnd)
    }
    
    
    
    
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    var city: String
    var temperature: String
    var icon: String
}


struct WeatherDatas: Codable {
    let address: String
    let currentConditions: CurrentConditions
}

struct CurrentConditions: Codable {
    let temp: Double
    let conditions: String
    let icon: String
}

struct weather_widjetEntryView : View {
    var entry: Provider.Entry
    var body: some View {
        VStack {
            Text(entry.city)
                .font(.title)
            HStack{
                Image(entry.icon)
                    .resizable()
                    .frame(width: 40, height: 40)
                Text("\(entry.temperature)°")
                    .font(.title)
            }
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.customBlue)
        .containerBackground(.fill, for: .widget)
        
    }
}

struct weather_widjet: Widget {
    let kind: String = "weather_widjet"
    
    
    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
            weather_widjetEntryView(entry: entry)
        }
        .contentMarginsDisabled()
    }
        
}


#Preview(as: .systemSmall) {
    weather_widjet()
} timeline: {
    SimpleEntry(date: Date(), city: "khujand", temperature: "10", icon: "clear-day")
}


