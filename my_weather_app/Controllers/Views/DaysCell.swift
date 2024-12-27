//
//  DailyCell.swift
//  my_weather_app
//
//  Created by Haidarov N on 12/27/24.
//

import UIKit

class DaysCell: UITableViewCell {
    let dayLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12)
        label.textColor = .systemGray
        label.textAlignment = .center
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12)
        label.textColor = .systemGray
        label.textAlignment = .center
        return label
    }()
    
    let imgView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let minTempLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12)
        label.textColor = .systemGray
        label.textAlignment = .center
        return label
    }()
    
    let desc: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12)
        label.textColor = .systemGray
        label.textAlignment = .left
        return label
    }()
    
    let maxTempLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12)
        label.textColor = .systemGray
        label.textAlignment = .center
        return label
    }()
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    private func setupViews() {
//        contentView.addSubview(dayLabel)
//        dayLabel.snp.makeConstraints { make in
//            make.centerY.equalToSuperview()
//            make.left.equalToSuperview().offset(10)
//        }
        
        contentView.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(10)
        }
        
        contentView.addSubview(imgView)
        imgView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(dateLabel.snp.right).offset(10)
            make.width.height.equalTo(20)
        }
        contentView.addSubview(minTempLabel)
        minTempLabel.snp.makeConstraints { make in
            make.left.equalTo(imgView.snp.right).offset(10)
            make.centerY.equalToSuperview()
        }
       
        
        contentView.addSubview(maxTempLabel)
        maxTempLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-10)
            make.centerY.equalToSuperview()
        }
        
        contentView.addSubview(desc)
        desc.snp.makeConstraints { make in
//            make.right.equalTo(maxTempLabel.snp.left).offset(-10)
            make.left.equalTo(minTempLabel.snp.right).offset(10)
            make.centerY.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.43)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
