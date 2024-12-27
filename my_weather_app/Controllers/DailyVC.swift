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
    var currentTime: Double?

    //MARK: -UI Elements
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 30)
        label.textColor = .white
        label.textAlignment = .center
        label.text = String(daily?.datetime ?? "")
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
        label.font = .systemFont(ofSize: 30, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        label.text = "\(String(daily?.temp ?? 0))°"
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
        collectionView.backgroundColor = .systemBlue
        return collectionView
    }()
    
    //MARK: -
    
    lazy var sunrise = sun("sunrise", "\(daily?.sunrise ?? "")")
    lazy var sunset = sun("sunset", "\(daily?.sunset ?? "")")

    //MARK: -Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
        setupUI()
        delegates()

    }
    
    //MARK: - methods
    private func setupUI() {
        view.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(view.layoutMarginsGuide)
            make.centerX.equalToSuperview()
        }
        
        view.addSubview(tempLabel)
        tempLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(20)
            make.width.height.equalTo(50)
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
            make.top.equalTo(tempLabel.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(120)
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
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(weatherIcon.snp.bottom).offset(10)
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
            return hours.filter { Double($0.datetime.prefix(2)) ?? 0 >= currentHour }.count
        }
        return daily?.hours.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? DailyCell else {
            return UICollectionViewCell()
        }

        let filteredHours: [Hour]
        if today, let currentHour = currentTime, let hours = daily?.hours {
            filteredHours = hours.filter { Double($0.datetime.prefix(2)) ?? 0 >= currentHour }
            
        } else {
            filteredHours = daily?.hours ?? []
        }

        let hour = filteredHours[indexPath.row]
        cell.timeLabel.text = (today && (Double(hour.datetime.prefix(2)) == currentTime)) ? "Now" : String(hour.datetime.prefix(5))
        cell.imageView.image = UIImage(named: hour.icon)
        cell.descLabel.text = hour.conditions
        cell.windLabel.text = "Скорост ветра: \(hour.windspeed) m/s"
        cell.temperatureLabel.text = "\(hour.temp)°"
        cell.feelsLikeLabel.text = "Feels like: \(hour.feelslike)°"
        
        return cell
    }
}
