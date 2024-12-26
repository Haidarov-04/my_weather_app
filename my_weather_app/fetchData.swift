//
//  fetchData.swift
//  my_weather_app
//
//  Created by Haidarov N on 12/25/24.
//

import Foundation
import Alamofire

//class fetchData {
//    func fetchData(){
//            let urlString : String
//
//            //        guard let url = URL(string: urlString) else {
//            print("Invalid URL")
//            return
//        }
//
//        let task = URLSession.shared.dataTask(with: url) { data, response, error in
//            if let error = error {
//                print("Error: \(error.localizedDescription)")
//                return
//            }
//
//            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
//                print("Invalid response")
//                return
//            }
//
//            guard let data = data else {
//                print("No data received")
//                return
//            }
//
//            do {
//                let decoder = JSONDecoder()
//                let decodedData = try decoder.decode(WeatherDatas.self, from: data)
//
//                DispatchQueue.main.async { [weak self] in
//                    self?.weatherData = decodedData
//                    print("Fetched weather data: \(self?.weatherData)")
//                }
//            } catch {
//                print("Decoding error: \(error.localizedDescription)")
//            }
//        }
//        task.resume()
//}
//}
