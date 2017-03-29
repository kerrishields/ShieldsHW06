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
    var currentIcon = ""
    var currentTime = 0.0
    var timeZone = ""
    
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
                if let icon = json["currently"]["icon"].string {
                    print("icon inside getweather= \(icon)")
                    self.currentIcon = icon
                } else {
                    print("cannot return temperature")
                }
                if let time = json["currently"]["time"].double {
                    print("time inside getweather= \(time)")
                    self.currentTime = time
                } else {
                    print("cannot return time")
                }
                if let timeZone = json["timezone"].string {
                    print("time zone inside getweather= \(timeZone)")
                    self.timeZone = timeZone
                } else {
                    print("cannot return timezone")
                }

            case .failure(let error):
                print(error)
            }
            completed()
        }
        
    }
}
