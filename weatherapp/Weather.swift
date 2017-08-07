//
//  Weather.swift
//  weatherapp

//  Created by Asad on 05/08/2017.
//  Copyright © 2017 Asad. All rights reserved.
//

import UIKit
import Alamofire

class Weather{

    var _cityName: String!
    var _date: String!
    var _weatherType: String!
    var _currentTemp: String!
    
    
    var cityName: String {
        
        if _cityName == nil{
            _cityName = ""
        }
        return _cityName
    }
    
    var weatherType: String {
        
        if _weatherType == nil{
        
            _weatherType = ""
        }
        return _weatherType
    }
    
    var currentTemp: String {
        if _currentTemp == nil{
            _currentTemp = ""
        }
        return _currentTemp
    }
    
    var date: String{
        
        if _date == nil {
            _date = ""
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        
        let currentDate = dateFormatter.string(from: Date())
        self._date = "Today, \(currentDate)"
        
        return _date
    }
    
    // tells when its finished
    func downloadWeatherData(completed: @escaping DownloadComplete){
    
             //let weatherURL = URL(string: CURRENT_WEATHER_URL)!
        
        Alamofire.request(CURRENT_WEATHER_URL, method: .get)
                .responseJSON { (response) in
                    
                    
                    if let dict = response.result.value as? Dictionary<String, AnyObject> {
                        
                        if let name = dict["name"] as? String {
                            self._cityName = name
                        }
                        
                        if let weather = dict["weather"] as? [Dictionary<String, AnyObject>] {
                            
                            if let main = weather[0]["main"] as? String {
                                self._weatherType = main
                            }
                        }
                        
                        if let main = dict["main"] as? Dictionary<String, AnyObject> {
                            if let currentTemperature = main["temp"] as? Double {
                                
                                let celciusTemperature = Double(currentTemperature - 273.15)
                                
                                self._currentTemp =   (String(format: "%.2f", celciusTemperature))+"°"
                                
                            }
                        }
                         completed()
                        
                    }
                    
                    
                    
        }
       
    }
    
}
