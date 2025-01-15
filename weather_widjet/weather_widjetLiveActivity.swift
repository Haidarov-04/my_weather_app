//
//  weather_widjetLiveActivity.swift
//  weather_widjet
//
//  Created by Haidarov N on 1/14/25.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct weather_widjetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct weather_widjetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: weather_widjetAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension weather_widjetAttributes {
    fileprivate static var preview: weather_widjetAttributes {
        weather_widjetAttributes(name: "World")
    }
}

extension weather_widjetAttributes.ContentState {
    fileprivate static var smiley: weather_widjetAttributes.ContentState {
        weather_widjetAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: weather_widjetAttributes.ContentState {
         weather_widjetAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: weather_widjetAttributes.preview) {
   weather_widjetLiveActivity()
} contentStates: {
    weather_widjetAttributes.ContentState.smiley
    weather_widjetAttributes.ContentState.starEyes
}
