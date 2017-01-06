//
//  otherDaysCell.swift
//  WeatherApp
//
//  Created by Ebubekir on 12/27/16.
//  Copyright © 2016 Ebubekir. All rights reserved.
//

import UIKit

class otherDaysCell: UITableViewCell {

    @IBOutlet weak var weatherPicture: UIImageView!
    @IBOutlet weak var weatherDay: UILabel!
    
    
    @IBOutlet weak var weatherType: UILabel!
    @IBOutlet weak var weatherMaxTemp: UILabel!
    
    
    @IBOutlet weak var weatherMinTemp: UILabel!
    
    func updateCell(weather: MultipleWeather){
        DispatchQueue.global().sync {
            
            weatherDay.text = weather.day
            weatherMaxTemp.text = weather.maxTemp
            weatherMinTemp.text = weather.minTemp
            weatherType.text = weather.weatherType
            
            weatherPicture.image = UIImage(named: weather.weatherType)
        }
    }

}
