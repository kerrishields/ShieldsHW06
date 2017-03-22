//
//  DetailVC.swift
//  WeatherGift
//
//  Created by Kerri Shields on 3/14/17.
//  Copyright © 2017 Kerri Shields. All rights reserved.
//

import UIKit
import CoreLocation

class DetailVC: UIViewController {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var currentImage: UIImageView!
    
    var currentPage = 0
    var locationsArray = [WeatherLocation]()
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.delegate = self
        if currentPage == 0 {
            getLocation()
        }
        locationsArray[currentPage].getWeather {
            self.updateUserInterface()
        }
        
    }

    func updateUserInterface() {
        
        let isHidden = (locationsArray[currentPage].currentTemp == -999.9)
        
        temperatureLabel.isHidden = isHidden
        locationLabel.isHidden = isHidden
      
        
        
        locationLabel.text = locationsArray[currentPage].name
        dateLabel.text = locationsArray[currentPage].coordinates
        let curTemperature = String(format: "%3.f", locationsArray[currentPage].currentTemp) + "°"
        temperatureLabel.text = curTemperature
        print("curTemperature is \(curTemperature)")
        summaryLabel.text = locationsArray[currentPage].dailySummary
    }


}

extension DetailVC: CLLocationManagerDelegate {
    
    func getLocation() {
        let status = CLLocationManager.authorizationStatus()
        
        handleLocationAuthorizationStatus(status: status)
        
    }
    func handleLocationAuthorizationStatus(status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.startUpdatingLocation()
        case .denied:
            print("user has not authorized location services")
        case .restricted:
            print("access denied - likely parental controls preventing location use in this app")

    }
                }
    
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        handleLocationAuthorizationStatus(status: status)
    }
    
   
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
       
        if currentPage == 0 {
        
        let geoCoder = CLGeocoder()
        
        
        currentLocation = locations.last
        
        
        let currentLat = "\(currentLocation.coordinate.latitude)"
        let currentLong = "\(currentLocation.coordinate.longitude)"
        
        print("coordinates are: " + currentLat + currentLong)
    
        var place = ""
        geoCoder.reverseGeocodeLocation(currentLocation, completionHandler: {placemarks, error in
            if placemarks != nil {
                let placemark = placemarks!.last
                place = (placemark?.name!)!
            } else {
                print("error retrieving place. error code: \(error)")
                place = "parts unknown"
            }
            print(place)
            self.locationsArray[0].name = place
            self.locationsArray[0].coordinates = currentLat + "," + currentLong
            self.locationsArray[0].getWeather(){
                self.updateUserInterface()
            }
            
        })
        locationManager.stopUpdatingLocation()
    }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error getting location")
    }
}
