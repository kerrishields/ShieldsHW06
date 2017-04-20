//
//  HourlyWeatherCell.swift
//  WeatherGift
//
//  Created by Kerri Shields on 4/18/17.
//  Copyright © 2017 Kerri Shields. All rights reserved.
//

import UIKit

class HourlyWeatherCell: UICollectionViewCell {
    
    @IBOutlet weak var hourlyTime: UILabel!
    @IBOutlet weak var hourlyTemp: UILabel!
    @IBOutlet weak var hourlyIcon: UIImageView!
    @IBOutlet weak var hourlyPrecipProb: UILabel!
    @IBOutlet weak var raindropIcon: UIImageView!
    
    
    func configureCollectionCell (hourlyForecast: WeatherLocation.HourlyForecast, timeZone: String) {
        
      
        
        hourlyTemp.text = String(format: "%2.f", hourlyForecast.hourlyTemp) + "°"
        hourlyIcon.image = UIImage(named: "small-" + hourlyForecast.hourlyIcon)
        hourlyPrecipProb.text = String(format: "%2.f", hourlyForecast.hourlyPrecipProb * 100) + "%"
        let isHidden = !(hourlyForecast.hourlyPrecipProb >= 0.30 || hourlyForecast.hourlyIcon == "rain")
        hourlyPrecipProb.isHidden = isHidden
        raindropIcon.isHidden = isHidden
        
        let usableDate = Date(timeIntervalSince1970: hourlyForecast.hourlyTime)
        let hourlytimeZone = TimeZone(identifier: timeZone)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "ha"
        dateFormatter.timeZone = hourlytimeZone
        
        let hour = dateFormatter.string(from: usableDate)
        hourlyTime.text = hour
        
    }
    
    
}
