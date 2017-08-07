//
//  Forecast.swift
//  weatherapp

//  Created by Asad on 05/08/2017.
//  Copyright © 2017 Asad. All rights reserved.
//

import UIKit
import Alamofire

class Forecast {
    
    var _highTemp: Double!
    var _lowtemp: Double!
    var _date: String!
    var _weatherType: String!
    
    var date: String {
        if _date == nil {
            _date = ""
        }
        return _date
    
    }
    
    var hightemp: Double {
        if _highTemp == nil {
            _highTemp = 0.0
        }
        return _highTemp
    
    }
    
    var lowTemp: Double {
        if _lowtemp == nil {
            _lowtemp = 0.0
        }
        return _lowtemp
    
    }
    
    var weatherType: String {
        if _weatherType == nil {
            _weatherType = ""
        }
        return _weatherType
    }
    
    init (weatherForecastDict: Dictionary<String, AnyObject>){
        
        if let temp = weatherForecastDict["temp"] as? Dictionary <String, AnyObject> {
            
            if let minTemp = temp["min"] as? Double {
            
                let minCelcius = Double(minTemp - 273.15)
                self._lowtemp = Double(String(format: "%.2f", minCelcius))
            
            }
            
            if let maxTemp = temp["max"] as? Double {
                
                let maxCelcius = Double(maxTemp - 273.15)
                self._highTemp = Double(String(format: "%.2f", maxCelcius))
            }
            
            if let weather = weatherForecastDict["weather"] as? [Dictionary <String, AnyObject>] {
                
                if let main = weather[0]["main"] as? String {
                    
                    self._weatherType = main
                }
            }
            
            if let date = weatherForecastDict["dt"] as? Double {
               
                let unixConvertedDate = Date(timeIntervalSince1970: date)
                let dateFormatter = DateFormatter()
                dateFormatter.timeStyle = .none
                dateFormatter.dateFormat = "EEEE"
                dateFormatter.dateStyle = .full
                self._date = unixConvertedDate.dayOfTheWeek()
                
                
            }
            
            
        }
    
    }

}

// converts UNIX datetimestamp to string i.e( 1502002800 to Wednesday)

extension Date {
    
    func dayOfTheWeek () -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE" // the full name of day
        //dateFormatter.timeStyle = .none
        return dateFormatter.string(from: self) // self,gets date in this VC
        
    }
}





















