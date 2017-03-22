//
//  WeatherLocation.swift
//  WeatherGift
//
//  Created by Kerri Shields on 3/20/17.
//  Copyright © 2017 Kerri Shields. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class WeatherLocation {
    var name = ""
    var coordinates = ""
    var currentTemp = -999.9
    var dailySummary = ""
    
    func getWeather(completed: @escaping () -> ()) {
        
        let weatherURL = urlBase + urlAPIKey + coordinates
        print(weatherURL)
        
        Alamofire.request(weatherURL).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                if let temperature = json["currently"]["temperature"].double {
                    print("temp inside getweather= \(temperature)")
                    self.currentTemp = temperature
                } else {
                    print("cannot return temp")
                }
                if let summary = json["daily"]["summary"].string {
                    print("summary inside getweather= \(summary)")
                    self.dailySummary = summary
                } else {
                    print("cannot return summary")
                }
            case .failure(let error):
                print(error)
            }
            completed()
        }
        
    }
}
