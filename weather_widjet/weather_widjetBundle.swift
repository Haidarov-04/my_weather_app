//
//  weather_widjetBundle.swift
//  weather_widjet
//
//  Created by Haidarov N on 1/14/25.
//

import WidgetKit
import SwiftUI

@main
struct weather_widjetBundle: WidgetBundle {
    var body: some Widget {
        weather_widjet()
        weather_widjetControl()
        weather_widjetLiveActivity()
    }
}
