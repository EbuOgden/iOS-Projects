//
//  ViewController.swift
//  WeatherApp
//
//  Created by Ebubekir on 12/13/16.
//  Copyright © 2016 Ebubekir. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire

class WeatherVC: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate{

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var dailyFahreneit: UILabel!
    @IBOutlet weak var placeLabel: UILabel!
    
    @IBOutlet weak var currentWeatherImage: UIImageView!
    @IBOutlet weak var currentWeatherType: UILabel!
    
    @IBOutlet weak var otherDaysTable: UITableView!
    
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    var weather: DailyWeather!
    
    var forecast: MultipleWeather!
    var forecasts = [MultipleWeather!]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        otherDaysTable.delegate = self
        otherDaysTable.dataSource = self
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization() // -> Get location data when application is in foreground
        
        // locationManager.requestAlwaysAuthorization() // -> Get location data always
        
        locationManager.startMonitoringSignificantLocationChanges()
        
        weather = DailyWeather()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locationAuthStatus()
    }
    
//    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
//        locationAuthStatus()
//    }
    
    func locationAuthStatus(){
        
        
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            currentLocation = locationManager.location
            Location.sharedInstance.latitude = currentLocation.coordinate.latitude
            Location.sharedInstance.longitude = currentLocation.coordinate.longitude
            
            weather.getWeatherDetail {
                self.downloadForecast {
                    self.updateMainUI()
                }
            }

        }
        else {
            locationManager.requestWhenInUseAuthorization()
            locationAuthStatus()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.forecasts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { // Fill Cell
        
        if let cell = otherDaysTable.dequeueReusableCell(withIdentifier: "weatherDay", for: indexPath) as? otherDaysCell {

            let eachDay = self.forecasts[indexPath.row]
            
            cell.updateCell(weather: eachDay!)
            
            return cell
            
        }
        else{
            return UITableViewCell()
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func numberOfSections(in tableView: UITableView) -> Int { // Headers or footers so we don't need another things but cells.
        return 1
    }
    
    func updateMainUI(){
        dateLabel.text = weather.date
        dailyFahreneit.text = weather.currentTemp
        currentWeatherType.text = weather.weatherType
        placeLabel.text = weather.cityName
        
        currentWeatherImage.image = UIImage(named: weather.weatherType)
    }
    
    func downloadForecast(completed: @escaping DownloadComplete) {
        let otherDaysURL = URL(string: FORECAST_WEATHER_URL)
        
        DispatchQueue.global().async {
            Alamofire.request(otherDaysURL!).responseJSON { response in
                
                let result = response.result
                
                if let dictionary = result.value as? Dictionary<String, Any> {
                    
                    if let weathersArray = dictionary["list"] as? [Dictionary<String, Any>] {
                        
                        for eachDay in weathersArray {
                            let day = MultipleWeather(dailyData: eachDay)
                            self.forecasts.append(day)
                        }
                        
                    }
                }
                
                self.forecasts.remove(at: 0)
                self.otherDaysTable.reloadData()
                completed()
            }
        }
        
    }


}

