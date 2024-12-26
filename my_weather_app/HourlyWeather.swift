//
//  File.swift
//  my_weather_app
//
//  Created by Haidarov N on 12/26/24.
//

import Foundation
import UIKit

import UIKit
import SnapKit

class HourlyWeatherView: UIView {
    
    private var hour: String
    private var icon: String
    private var temp: Double
    
    // Custom initializer
    init(hour: String, icon: String, temp: Double) {
        self.hour = hour
        self.icon = icon
        self.temp = temp
        super.init(frame: .zero)
        setupUI()
        configure(hour: hour, icon: icon, temp: temp)
    }
    
    // Subviews
    private let hourLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    private let weatherImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let tempLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    // Setup the view hierarchy and layout
    private func setupUI() {
        addSubview(hourLabel)
        addSubview(weatherImageView)
        addSubview(tempLabel)
        
        hourLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(3)
            make.centerX.equalToSuperview()
        }
        
        weatherImageView.snp.makeConstraints { make in
            make.top.equalTo(hourLabel.snp.bottom).offset(15)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(20)
        }
        
        tempLabel.snp.makeConstraints { make in
            make.top.equalTo(weatherImageView.snp.bottom).offset(15)
            make.centerX.equalToSuperview()
        }
    }
    
    // Configure the view with dynamic data
    func configure(hour: String, icon: String, temp: Double) {
        hourLabel.text = hour == "Now" ? "Now" : formatTime(hour: hour)
        weatherImageView.image = UIImage(named: icon)
        tempLabel.text = "\(temp)°"
    }
    
    func formatTime(hour: String) -> String {
        let time = String(hour.prefix(1) == "0" ? hour.prefix(2) : hour.prefix(2))
        return time
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

