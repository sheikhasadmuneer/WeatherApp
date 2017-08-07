//
//  Constants.swift
//  weatherapp

//  Created by Asad on 05/08/2017.
//  Copyright © 2017 Asad. All rights reserved.
//

import Foundation

let API_KEY = "e03c2650b2cfdaefd1772a2d0487fcf8"
let LATITUDE = SingletonLocation.singletonLocationObject.latitude
let LONGITUDE = SingletonLocation.singletonLocationObject.longitude


let CURRENT_WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather?lat=\(LATITUDE!)&lon=\(LONGITUDE!)&appid=e03c2650b2cfdaefd1772a2d0487fcf8"


let FORECAST_URL = "https://api.openweathermap.org/data/2.5/forecast/daily?lat=\(LATITUDE!)&lon=\(LONGITUDE!)&cnt=10&appid=e03c2650b2cfdaefd1772a2d0487fcf8"

typealias DownloadComplete = () -> () // this is going to tell our func when its complete i.e a clossure

 
