//
//  DailyCell.swift
//  my_weather_app
//
//  Created by Haidarov N on 12/27/24.
//

import UIKit

class DailyCell: UICollectionViewCell {
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let descLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15)
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    
    let windLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12)
        label.textColor = .white
        label.textAlignment = .right
        return label
    }()
    
    
    let temperatureLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 40)
        label.textColor = .systemBlue
        label.textAlignment = .center
        return label
    }()
    
    let feelsLikeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        contentView.backgroundColor = .black.withAlphaComponent(0.3)
        contentView.layer.cornerRadius = 10
    }
    
    
    private func setupViews() {
        contentView.addSubview(timeLabel)
        timeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.left.equalToSuperview().offset(15)
        }
        
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(15)
            make.width.height.equalTo(80)
        }
        
        contentView.addSubview(descLabel)
        descLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-15)
            make.left.equalToSuperview().offset(15)
        }
        
        contentView.addSubview(windLabel)
        windLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
        }
        
        contentView.addSubview(temperatureLabel)
        temperatureLabel.snp.makeConstraints { make in
            make.top.equalTo(windLabel.snp.bottom).offset(15)
            make.right.equalToSuperview().offset(-15)
        }
        
        contentView.addSubview(feelsLikeLabel)
        feelsLikeLabel.snp.makeConstraints { make in
            make.top.equalTo(temperatureLabel.snp.bottom).offset(15)
            make.right.equalToSuperview().offset(-15)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
