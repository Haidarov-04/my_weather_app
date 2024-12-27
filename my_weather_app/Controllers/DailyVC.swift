//
//  DailyVC.swift
//  my_weather_app
//
//  Created by Haidarov N on 12/27/24.
//

import UIKit

class DailyVC: UIViewController {
    var daily: Day?
    var today = false
    var currentTime: Double?

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

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        delegates()

    }
    
    private func setupUI() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.height.equalToSuperview()
        }
    }
    
    private func delegates(){
        collectionView.delegate = self
        collectionView.dataSource = self
    }


}


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
