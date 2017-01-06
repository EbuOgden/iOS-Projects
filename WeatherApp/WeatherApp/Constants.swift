//
//  Constants.swift
//  WeatherApp
//
//  Created by Ebubekir on 12/19/16.
//  Copyright © 2016 Ebubekir. All rights reserved.
//

import Foundation

let BASE_URL = "http://api.openweathermap.org/data/2.5/weather?"



let FORECAST_URL = "http://api.openweathermap.org/data/2.5/forecast/daily?"
let DAY_COUNT = "&cnt=5"

let LATITUDE = "&lat=\(Location.sharedInstance.latitude!)"
let LONGITUDE = "&lon=\(Location.sharedInstance.longitude!)"

let APP_ID = "&appid="
let API_KEY = "1eae531c6ec7e058bcd3559134772f23"

typealias DownloadComplete = () -> ()

let CURRENT_WEATHER_URL = "\(BASE_URL)\(LATITUDE)\(LONGITUDE)\(APP_ID)\(API_KEY)"

let FORECAST_WEATHER_URL = "\(FORECAST_URL)\(DAY_COUNT)\(LATITUDE)\(LONGITUDE)\(APP_ID)\(API_KEY)"
