//
//  DailyVC.swift
//  my_weather_app
//
//  Created by Haidarov N on 12/27/24.
//

import UIKit

class DailyVC: UIViewController {
    //MARK: -
    var daily: Day?
    var today = false
    var currentTime: Int?

    //MARK: -UI Elements
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Georgia", size: 25)
        label.textColor = .white
        label.textAlignment = .center
        label.text = today ? "Today": String(daily?.datetime ?? "")
        return label
    }()
    
    lazy var minTempLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        label.text = "\(String(daily?.tempmin ?? 0))°"
        return label
    }()
    
    lazy var tempLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 40, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        label.text = "\(String(daily?.temp ?? 0))°"
        return label
    }()
    
    lazy var feelsLikeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12)
        label.textColor = .white
        label.textAlignment = .center
        label.text = "Feels Like: \(String(daily?.feelslike ?? 0))°"
        return label
    }()
    
    lazy var maxTempLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        label.text = "\(String(daily?.tempmax ?? 0))°"
        return label
    }()
    
    lazy var weatherIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "\(daily?.icon ?? "")")
        return imageView
    }()
    
    lazy var sun:(String, String)-> UIView = {icon, time in
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: icon)
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        label.text = String(time.prefix(5))
        view.addSubview(imageView)
        imageView.snp.makeConstraints{make in
            make.top.equalToSuperview().offset(3)
            make.width.height.equalTo(40)
            make.centerX.equalToSuperview()
        }
        view.addSubview(label)
        label.snp.makeConstraints{make in
            make.top.equalTo(imageView.snp.bottom).offset(3)
            make.centerX.equalToSuperview()
        }
        return view
    }
    
    lazy var descLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = daily?.description ?? ""
        return label
    }()
    
    lazy var windSpeed: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.textAlignment = .center
        label.text = "Скорост ветра: \(daily?.windspeed ?? 0) м/с"
        return label
    }()
    
    lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.itemSize = CGSize(width: view.frame.size.width * 0.9, height: 150)
        return layout
    }()
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(DailyCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.backgroundColor = UIColor(named: "customBlue")
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    //MARK: -
    lazy var sunrise = sun("sunrise", "\(daily?.sunrise ?? "")")
    lazy var sunset = sun("sunset", "\(daily?.sunset ?? "")")

    //MARK: -Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMainView()
        setupUI()
        delegates()

    }
    
    //MARK: - methods
    private func setupMainView() {
        view.backgroundColor = UIColor(named: "customBlue")
        navigationController?.navigationBar.tintColor = .white
        navigationItem.titleView = dateLabel
    }
    
    private func setupUI() {
        view.addSubview(tempLabel)
        tempLabel.snp.makeConstraints { make in
            make.top.equalTo(view.layoutMarginsGuide).offset(5)
            make.centerX.equalToSuperview()
        }
        
        view.addSubview(feelsLikeLabel)
        feelsLikeLabel.snp.makeConstraints { make in
            make.top.equalTo(tempLabel.snp.bottom).offset(2)
            make.centerX.equalToSuperview()
        }
        
        view.addSubview(minTempLabel)
        minTempLabel.snp.makeConstraints { make in
            make.centerY.equalTo(tempLabel.snp.centerY)
            make.centerX.equalToSuperview().multipliedBy(0.5)
        }
        
        view.addSubview(maxTempLabel)
        maxTempLabel.snp.makeConstraints { make in
            make.centerY.equalTo(tempLabel.snp.centerY)
            make.centerX.equalToSuperview().multipliedBy(1.5)
        }
        
        view.addSubview(weatherIcon)
        weatherIcon.snp.makeConstraints { make in
            make.top.equalTo(feelsLikeLabel.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(100)
        }
        
        view.addSubview(sunrise)
        sunrise.snp.makeConstraints { make in
            make.centerY.equalTo(weatherIcon.snp.centerY)
            make.centerX.equalToSuperview().multipliedBy(0.3)
            make.width.equalTo(40)
            make.height.equalTo(60)
        }
        
        view.addSubview(sunset)
        sunset.snp.makeConstraints { make in
            make.centerY.equalTo(weatherIcon.snp.centerY)
            make.centerX.equalToSuperview().multipliedBy(1.7)
            make.width.equalTo(40)
            make.height.equalTo(60)
        }
        
        view.addSubview(descLabel)
        descLabel.snp.makeConstraints { make in
            make.top.equalTo(weatherIcon.snp.bottom).offset(5)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
        }
        view.addSubview(windSpeed)
        windSpeed.snp.makeConstraints { make in
            make.top.equalTo(descLabel.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
        }
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(windSpeed.snp.bottom).offset(5)
            make.left.right.bottom.equalToSuperview()
            make.width.equalToSuperview()
            
        }
    }
    
    private func delegates(){
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}


//MARK: - DailyVC + UICollectionViewDelegate, UICollectionViewDataSource
extension DailyVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if today {
            guard let currentHour = currentTime, let hours = daily?.hours else { return 0 }
            return hours.filter { Int($0.datetime.prefix(2)) ?? 0 >= currentHour }.count
        }
        return daily?.hours.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? DailyCell else {
            return UICollectionViewCell()
        }

        let filteredHours: [Hour]
        if today, let currentHour = currentTime, let hours = daily?.hours {
            filteredHours = hours.filter { Int($0.datetime.prefix(2)) ?? 0 >= currentHour }
        } else {
            filteredHours = daily?.hours ?? []
        }

        let hour = filteredHours[indexPath.row]
        let now = (Int(hour.datetime.prefix(2)) == currentTime)
        
        cell.timeLabel.text = (today && now ) ? "Now" : String(hour.datetime.prefix(5))
        cell.imageView.image = UIImage(named: hour.icon)
        cell.descLabel.text = hour.conditions
        cell.windLabel.text = "Скорост ветра: \(hour.windspeed) m/s"
        cell.temperatureLabel.text = "\(hour.temp)°"
        cell.feelsLikeLabel.text = "Feels like: \(hour.feelslike)°"
        
        return cell
    }
}
