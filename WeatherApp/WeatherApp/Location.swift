//
//  Location.swift
//  WeatherApp
//
//  Created by Ebubekir on 1/4/17.
//  Copyright © 2017 Ebubekir. All rights reserved.
//

import Foundation

class Location{ // -> Singleton Class
    static var sharedInstance = Location()
    
    private init(){}
    
    var latitude: Double!
    var longitude: Double!
}
