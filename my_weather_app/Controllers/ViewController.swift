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
    let loadingView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "customBlue")
        return view
    }()
    
    let loadingActivity: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView()
        activity.color = .white
        activity.translatesAutoresizingMaskIntoConstraints = false
        activity.startAnimating()
        return activity
    }()
    
    
    let refreshControl = UIRefreshControl()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = UIColor(named: "customBlue")
        scrollView.showsVerticalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.refreshControl = refreshControl
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
        label.font = UIFont(name: "TimesNewRomanPSMT", size: 80)
        label.textAlignment = .center
        label.text = "--"
        return label
    }()
    
    lazy var feelsLikeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont(name: "TimesNewRomanPSMT", size: 17)
        label.textAlignment = .center
        label.text = "Feels like: --"
        return label
    }()
    
    var weatherImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .black.withAlphaComponent(0.3)
        imageView.layer.cornerRadius = 45
        return imageView
    }()
    
    var conditonLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont(name: "HoeflerText-Regular", size: 17)
        label.textAlignment = .center
        label.text = "-----"
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
        label.numberOfLines = 0
        label.text = "----------"
        return label
    }()
    
    var windSpeedLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont(name: "HoeflerText-Regular", size: 16)
        label.textAlignment = .left
        label.text = "Скорост ветра: --м/с"
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
    
    let hourlyStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .fillEqually
        view.spacing = 20
        return view
    }()
    
    let dailyView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black.withAlphaComponent(0.3)
        view.layer.cornerRadius = 10
        return view
    }()
    
    let dailyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont(name: "HoeflerText-Regular", size: 16)
        label.textAlignment = .left
        label.text = "Дневной прогноз"
        return label
    }()
    
    let tableview: UITableView = {
        let tableview = UITableView()
        tableview.translatesAutoresizingMaskIntoConstraints = false
        tableview.register(DaysCell.self, forCellReuseIdentifier: "cell")
        tableview.backgroundColor = .clear
        tableview.separatorColor = .gray.withAlphaComponent(0.5)
        tableview.rowHeight = 50
        tableview.isScrollEnabled = false
        return tableview
    }()
    
    
    lazy var hourlyDivider = divider()
    lazy var dailyDivider = divider()
    
    
    //MARK: -Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMainView()
        setupUI()
        fetchData()
        delegates()
        targets()
    }
    
    //MARK: - Methods
    private func setupMainView() {
        navigationItem.titleView = header
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(named: "customBlue")
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
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
            make.centerX.equalToSuperview().multipliedBy(0.5)
        }
        
        contentView.addSubview(feelsLikeLabel)
        feelsLikeLabel.snp.makeConstraints { make in
            make.top.equalTo(temperatureLabel.snp.bottom).offset(5)
            make.centerX.equalTo(temperatureLabel.snp.centerX)
        }
        
        contentView.addSubview(weatherImageView)
        weatherImageView.snp.makeConstraints { make in
            make.top.equalTo(adressLabel.snp.bottom).offset(10)
            make.centerX.equalToSuperview().multipliedBy(1.5)
            make.width.height.equalTo(90)
        }
        
        contentView.addSubview(conditonLabel)
        conditonLabel.snp.makeConstraints { make in
            make.centerY.equalTo(feelsLikeLabel.snp.centerY)
            make.centerX.equalTo(weatherImageView.snp.centerX)
            make.right.equalToSuperview().offset(-5)
        }
        
        contentView.addSubview(hourlyView)
        hourlyView.snp.makeConstraints { make in
            make.top.equalTo(feelsLikeLabel.snp.bottom).offset(15)
            make.width.equalToSuperview().multipliedBy(0.9)
            make.centerX.equalToSuperview()
//            make.height.equalTo(180)
        }
        
        hourlyView.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            
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
            make.right.equalTo(hourlyView).offset(-10)
            make.left.equalTo(hourlyView.snp.left).offset(10)
            make.height.equalTo(120)
        }
        
        hourlyScrollView.addSubview(hourlyStackView)
        hourlyStackView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(10)
        }
        
        contentView.addSubview(dailyView)
        dailyView.snp.makeConstraints { make in
            make.top.equalTo(hourlyView.snp.bottom).offset(10)
            make.width.equalToSuperview().multipliedBy(0.9)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-10)
        }
        
        dailyView.addSubview(dailyLabel)
        dailyLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(10)
        }
        
        dailyView.addSubview(dailyDivider)
        dailyDivider.snp.makeConstraints { make in
            make.top.equalTo(dailyLabel.snp.bottom).offset(5)
            make.width.equalToSuperview().multipliedBy(0.95)
            make.centerX.equalToSuperview()
            make.height.equalTo(1)
        }
        
        dailyView.addSubview(tableview)
        tableview.snp.makeConstraints { make in
            make.top.equalTo(dailyDivider.snp.bottom).offset(5)
            make.right.equalToSuperview().offset(-20)
            make.left.bottom.equalToSuperview()
            make.height.equalTo(750)
        }
        
        view.addSubview(loadingView)
        loadingView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.height.equalToSuperview()
        }
        
        loadingView.addSubview(loadingActivity)
        loadingActivity.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(50)
        }

    
    }

    private func fetchData() {
        let urlString = "https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline/\(adress)?unitGroup=metric&include=days%2Chours%2Ccurrent&lang=ru&key=8UR5K2HXEMSRTAGZZLSETRAVQ&contentType=json"
        
        AF.request(urlString, method: .get).responseDecodable(of: WeatherDatas.self){ response in
            switch response.result {
            case .success(let data):
                self.weatherData = data
                DispatchQueue.main.async {
                    self.updateUI()
                    self.scrollView.refreshControl?.endRefreshing()
                    self.loadingView.removeFromSuperview()
                    self.loadingActivity.removeFromSuperview()
                }
            case .failure(let error):
                self.checkConnection()
                print("Error: \(error.localizedDescription)")
                self.loadingView.removeFromSuperview()
                self.loadingActivity.removeFromSuperview()
            }
            
        }
        
        
    }
    
    private func updateUI(){
        temperatureLabel.text = "\(weatherData?.currentConditions.temp ?? 0)°"
        feelsLikeLabel.text = "Feels like: \(weatherData?.currentConditions.feelslike ?? 0)°"
        conditonLabel.text = "\(weatherData?.currentConditions.conditions ?? "")"
        weatherImageView.image = UIImage(named: weatherData?.currentConditions.icon ?? "")
        weatherImageView.backgroundColor = .none
        descriptionLabel.text = weatherData?.days[0].description
        windSpeedLabel.text = "Скорост ветра: \(weatherData?.currentConditions.windspeed ?? 0) м/с"
        addHourlyViews()
        tableview.isHidden = false
        tableview.reloadData()
    }
    
    private func addHourlyViews() {
        let currentHour = currentTime()
        for (_, hour) in weatherData.days[0].hours.enumerated() {
            let now = Int(hour.datetime.prefix(2))! == currentHour
            if Int(hour.datetime.prefix(2))! >= currentHour {
                let hourly = HourlyWeatherView(hour: now ? "Now": hour.datetime, icon: hour.icon, temp: hour.temp)
                hourly.snp.makeConstraints { make in
                    make.width.equalTo(50)
                }
                hourlyStackView.addArrangedSubview(hourly)
            }
        }
        
        for (_, hour) in weatherData.days[1].hours.enumerated() {
            if hourlyStackView.subviews.count <= 24{
                let hourly = HourlyWeatherView(hour: hour.datetime, icon: hour.icon, temp: hour.temp)
                hourly.snp.makeConstraints { make in
                    make.width.equalTo(50)
                }
                hourlyStackView.addArrangedSubview(hourly)
            }
        }
    }
    
    private func delegates() {
        tableview.delegate = self
        tableview.dataSource = self
    }
    
    private func targets() {
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
    }
    
    private func currentTime()->Int{
        let date = Date()
        let calendar = Calendar.current
        return  calendar.component(.hour, from: date)
    }
    
    private func checkConnection(){
        let ac = UIAlertController(title: "Пожалуйста, проверьте подключение", message: nil, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    @objc
    func refresh(_ sender: Any) {
        fetchData()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.scrollView.refreshControl?.endRefreshing()
        }
    }
    
    
    
    
    
    
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = weatherData?.days.count{
            return count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)  as? DaysCell else { return UITableViewCell()}
        if let day = weatherData?.days[indexPath.row]{
            cell.dateLabel.text = indexPath.row == 0 ? "Today" : day.datetime
            cell.imgView.image = UIImage(named: day.icon)
            cell.minTempLabel.text = "\(day.tempmin)°"
            cell.desc.text = "\(day.conditions)                                              "
            cell.maxTempLabel.text = "\(day.tempmax)°"
            
        }
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DailyVC()
        vc.daily = weatherData?.days[indexPath.row]
        vc.today = indexPath.row == 0
        vc.currentTime = currentTime()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
