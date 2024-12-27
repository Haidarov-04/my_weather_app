//
//  ViewController.swift
//  my_weather_app
//
//  Created by Haidarov N on 12/25/24.
//

import UIKit
import Alamofire
import SnapKit

class ViewController: UIViewController {
    //MARK: -
    let adress = "Khujand"
    var weatherData: WeatherDatas!
    
    //MARK: -UI Elements
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .systemBlue.withAlphaComponent(0.5)
        scrollView.showsVerticalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var header: UILabel = {
       let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: "Georgia", size: 20)
        label.textAlignment = .center
        label.text = "Weather App"
        return label
    }()
    
    lazy var adressLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont(name: "HoeflerText-Regular", size: 45)
        label.textAlignment = .center
        label.text = adress
        return label
    }()
    
    lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont(name: "TimesNewRomanPSMT", size: 100)
        label.textAlignment = .center
        label.text = "0°"
        return label
    }()
    
    lazy var feelsLikeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont(name: "TimesNewRomanPSMT", size: 17)
        label.textAlignment = .center
        label.text = "Feels like: 0°"
        return label
    }()
    
    var weatherImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    var conditonLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont(name: "HoeflerText-Regular", size: 20)
        label.textAlignment = .center
        return label
    }()
    
    let hourlyView:UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        view.backgroundColor = .black.withAlphaComponent(0.3)
        return view
    }()
    
    let divider:()->UIView = {
        let divider = UIView()
        divider.backgroundColor = .lightGray
        divider.translatesAutoresizingMaskIntoConstraints = false
        return divider
    }
    
    var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont(name: "HoeflerText-Regular", size: 18)
        label.textAlignment = .left
        label.text = " "
        return label
    }()
    
    var windSpeedLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont(name: "HoeflerText-Regular", size: 16)
        label.textAlignment = .left
        label.text = " "
        return label
    }()
    
    let hourlyScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delaysContentTouches = false
        scrollView.canCancelContentTouches = true
        return scrollView
    }()
    
    let hourlyContentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let hourlyStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .fillEqually
        view.spacing = 20
        return view
    }()
    
    lazy var hourlyDivider = divider()
    
    //MARK: -Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMainView()
        setupUI()
        fetchData()
    }
    
    //MARK: -
    private func setupMainView() {
        navigationItem.titleView = header
    }
    
    private func setupUI() {
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        contentView.addSubview(adressLabel)
        adressLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.centerX.equalToSuperview()
        }
        
        contentView.addSubview(temperatureLabel)
        temperatureLabel.snp.makeConstraints { make in
            make.top.equalTo(adressLabel.snp.bottom).offset(10)
            make.right.equalTo(view.snp.centerX).offset(-5)
        }
        contentView.addSubview(feelsLikeLabel)
        feelsLikeLabel.snp.makeConstraints { make in
            make.top.equalTo(temperatureLabel.snp.bottom).offset(3)
            make.left.equalTo(temperatureLabel.snp.left)
        }
        contentView.addSubview(weatherImageView)
        weatherImageView.snp.makeConstraints { make in
            make.top.equalTo(adressLabel.snp.bottom).offset(10)

            make.left.equalTo(view.snp.centerX).offset(35)
            make.width.height.equalTo(100)
        }
        contentView.addSubview(conditonLabel)
        conditonLabel.snp.makeConstraints { make in
            make.centerY.equalTo(feelsLikeLabel.snp.centerY)
            make.left.equalTo(view.snp.centerX).offset(5)
        }
        
        contentView.addSubview(hourlyView)
        hourlyView.snp.makeConstraints { make in
            make.top.equalTo(feelsLikeLabel.snp.bottom).offset(15)
            make.width.equalToSuperview().multipliedBy(0.9)
            make.centerX.equalToSuperview()
            make.height.equalTo(180)
        }
        
        hourlyView.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(10)
        }
        
        hourlyView.addSubview(windSpeedLabel)
        windSpeedLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(10)
        }
        
        hourlyView.addSubview(hourlyDivider)
        hourlyDivider.snp.makeConstraints { make in
            make.top.equalTo(windSpeedLabel.snp.bottom).offset(5)
            make.width.equalToSuperview().multipliedBy(0.95)
            make.centerX.equalToSuperview()
            make.height.equalTo(1)
        }

        view.addSubview(hourlyScrollView)
            hourlyScrollView.snp.makeConstraints { make in
                make.top.equalTo(hourlyDivider.snp.bottom).offset(10)
                make.bottom.equalTo(hourlyView.snp.bottom)
                make.right.equalTo(hourlyView)
                make.left.equalTo(hourlyView.snp.left).offset(10)
            }
            
            hourlyScrollView.addSubview(hourlyContentView)
            hourlyContentView.snp.makeConstraints { make in
                make.top.left.right.bottom.equalToSuperview()
                make.height.equalToSuperview()
            }
        
            hourlyContentView.addSubview(hourlyStackView)
            hourlyStackView.snp.makeConstraints { make in
                make.top.left.right.bottom.equalToSuperview()
                make.left.equalToSuperview().offset(10)
            }
        
//        hourlyStackView.subviews.count

        
    }
    
    
    
    
    private func fetchData() {
        let urlString = "https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline/\(adress)?unitGroup=metric&include=days%2Chours%2Ccurrent&lang=ru&key=8UR5K2HXEMSRTAGZZLSETRAVQ&contentType=json"
        
        AF.request(urlString, method: .get).responseDecodable(of: WeatherDatas.self){ response in
            switch response.result {
            case .success(let data):
                self.weatherData = data
                DispatchQueue.main.async {
                    self.updateUI()
                }
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
            
        }
        
    
    }
    
    func updateUI(){
        temperatureLabel.text = "\(weatherData?.currentConditions.temp ?? 0)°"
        feelsLikeLabel.text = "Feels like: \(weatherData?.currentConditions.feelslike ?? 0)°"
        conditonLabel.text = "\(weatherData?.currentConditions.conditions ?? "")"
        weatherImageView.image = UIImage(named: weatherData?.currentConditions.icon ?? "")
        descriptionLabel.text = weatherData?.days[0].description
        windSpeedLabel.text = "Скорост ветра: \(weatherData?.currentConditions.windspeed ?? 0) м/с"
        addHourlyViews()
        

        
    }
    
    
    func addHourlyViews() {
        for (index, hour) in weatherData.days[0].hours.enumerated() {
            if Double(hour.datetime.prefix(2))! == Double(weatherData.currentConditions.datetime.prefix(2))! {
                let hourly = HourlyWeatherView(hour: "Now", icon: hour.icon, temp: hour.temp)
                hourly.snp.makeConstraints { make in
                    make.width.equalTo(50)
                }
                hourlyStackView.addArrangedSubview(hourly)
            }
            
            if Double(hour.datetime.prefix(2))! > Double(weatherData.currentConditions.datetime.prefix(2))! {
                let hourly = HourlyWeatherView(hour: hour.datetime, icon: hour.icon, temp: hour.temp)
                hourly.snp.makeConstraints { make in
                    make.width.equalTo(50)
                }
                hourlyStackView.addArrangedSubview(hourly)
            }

        }
        
        for (index, hour) in weatherData.days[1].hours.enumerated() {
            if hourlyStackView.subviews.count <= 24{
                let hourly = HourlyWeatherView(hour: hour.datetime, icon: hour.icon, temp: hour.temp)
                hourly.snp.makeConstraints { make in
                    make.width.equalTo(50)
                }
                hourlyStackView.addArrangedSubview(hourly)
            }
        }
    }


}

