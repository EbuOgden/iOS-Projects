//
//  DailyWeather.swift
//  WeatherApp
//
//  Created by Ebubekir on 12/19/16.
//  Copyright © 2016 Ebubekir. All rights reserved.
//

import Foundation
import Alamofire

class DailyWeather {
    private var _cityName: String!
    private var _date: String!
    private var _weatherType: String!
    private var _currentTemp: String!
    private var _lowestTemp: String!
    private var _highestTemp: String!
    
    var cityName: String {
        if _cityName == nil {
            _cityName = ""
        }
        
        return self._cityName
    }
    
    var date: String {
        if self._date == nil {
            self._date = ""
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        
        let currentDate = dateFormatter.string(from: Date()) // -> Empty Date
        self._date = "Today, \(currentDate)"
        
        return self._date
        
    }
    
    var weatherType: String {
        if self._weatherType == nil {
            self._weatherType = ""
        }
        
        return self._weatherType
        
    }
    
    var currentTemp: String {
        if self._currentTemp == nil {
            self._currentTemp = ""
        }
        
        return self._currentTemp
    }
    
    var lowestTemp: String {
        set {
            self._lowestTemp = newValue
        }
        
        get {
            return self._lowestTemp
        }
    }
    
    var highestTemp: String {
        set {
            self._highestTemp = newValue
        }
        
        get {
            return self._highestTemp
        }
    }
    
    func getWeatherDetail(completed: @escaping DownloadComplete){
        
        let currentWeatherURL = URL(string: CURRENT_WEATHER_URL)
        
        Alamofire.request(currentWeatherURL!).responseJSON{ response in // -> After get json pass to response
            
            let result = response.result
            
            if let dictionary = result.value as? Dictionary<String, Any> { // -> Got the value
                
                print("DICTIONARY : \(dictionary)")
                
                if let cityName = dictionary["name"] as? String {
                    self._cityName = cityName.capitalized // -> Because we casted to String
                    
                }
                
                if let weatherType = dictionary["weather"] as? [Dictionary<String, Any>] {
                    // -> We used [], because in originally our JSON data's weather is an array.
                    
                    if weatherType.count > 1 {
                        if let main = weatherType[1]["main"] as? String {
                            self._weatherType = main
                            
                        }
                    }
                    else{
                        if let main = weatherType[0]["main"] as? String {
                            self._weatherType = main
                            
                        }
                    }
                    
                    
                    
                    
                }
                
                if let weather = dictionary["main"] as? Dictionary<String, Any> {
                    
                    if let dailyWeather = weather["temp"] as? Double {
                        
                        let celciusBefore = ((dailyWeather * 9) / 5) - 459.67
                        
                        let celcius = round(celciusBefore)
                        
                        self._currentTemp = String(celcius)
                        
                        
                    }
                }
            }
            
            completed()
        }
        
        

    }
}
