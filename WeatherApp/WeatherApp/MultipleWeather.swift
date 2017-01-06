//
//  MultipleWeather.swift
//  WeatherApp
//
//  Created by Ebubekir on 12/27/16.
//  Copyright © 2016 Ebubekir. All rights reserved.
//

import Foundation
import Alamofire

class MultipleWeather {
    
    private var _day: String!
    private var _weatherType: String!
    private var _maxTemp: String!
    private var _minTemp: String!
    
    var day: String {
        if self._day == nil {
            self._day = ""
        }
        
        return self._day
    }
    
    var weatherType: String{
        if self._weatherType == nil{
            self._weatherType = ""
        }
        
        return self._weatherType
    }
    
    var maxTemp: String{
        if self._maxTemp == nil {
            self._maxTemp = ""
        }
        
        return self._maxTemp
    }
    
    var minTemp: String{
        if self._minTemp == nil {
            self._minTemp = ""
        }
        
        return self._minTemp
    }
    
    init(dailyData: Dictionary<String, Any>){
        
        
        
        //print("DAILY DATA MAIN : \(dailyData["weather"])")
        
        if let temp = dailyData["temp"] as? Dictionary<String, Any> {
            
            let maxDailyKelvin = temp["max"] as! Double
            let minDailyKelvin = temp["min"] as! Double
            
            let maxCelciusBefore = ((maxDailyKelvin * 9) / 5) - 459.67
            let maxCelcius = round(maxCelciusBefore)
            
            let minCelciusBefore = ((minDailyKelvin * 9) / 5) - 459.67
            let minCelcius = round(minCelciusBefore)
            
            self._maxTemp = String(maxCelcius)
            self._minTemp = String(minCelcius)
            
        }
        
        if let weather = dailyData["weather"] as? [Dictionary<String, Any>] {
            self._weatherType = weather[0]["main"] as! String
        }
        
        if let date1970 = dailyData["dt"] as? Double {
            let date = Date(timeIntervalSince1970: date1970)
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .full
            dateFormatter.dateFormat = "EEEE"
            dateFormatter.timeStyle = .none
            
            self._day = date.dayOftheWeek()
            
        }
        
    }
    
    
}

extension Date { // We can use dayOftheWeek function at every Date format values
    
    func dayOftheWeek() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE" // Full name day of the week
        return dateFormatter.string(from: self)
        
    }
}

