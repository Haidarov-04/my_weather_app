//
//  FetchData.swift
//  my_weather_app
//
//  Created by Haidarov N on 1/9/25.
//

import Foundation
import Alamofire

protocol ViewModelDelegate: AnyObject{
    func reloadData(data: WeatherDatas)
    func failure()
}

class ViewModel{
    
    weak var delegate: ViewModelDelegate?
    
     func fetchData(adress: String) {
        let urlString = "https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline/\(adress)?unitGroup=metric&include=days%2Chours%2Ccurrent&lang=ru&key=8UR5K2HXEMSRTAGZZLSETRAVQ&contentType=json"
        
        AF.request(urlString, method: .get).responseDecodable(of: WeatherDatas.self){ response in
            switch response.result {
            case .success(let data):
                self.delegate?.reloadData(data: data)
                
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
                self.delegate?.failure()

            }
            
        }
    }
}
