//
//  WeatherCell.swift
//  weatherapp
//
//  Created by Asad on 06/08/2017.
//  Copyright © 2017 Asad. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {

    @IBOutlet weak var weatherTypeLbl: UILabel!
    @IBOutlet weak var minTempLbl: UILabel!
    @IBOutlet weak var maxTempLbl: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var dayLbl: UILabel!
    
    func configureCell(forecast: Forecast) {
        
        minTempLbl.text = "\(forecast.lowTemp)"
        maxTempLbl.text = "\(forecast.hightemp)"
        weatherTypeLbl.text = forecast.weatherType
        weatherIcon.image = UIImage(named: forecast.weatherType)
        dayLbl.text = forecast.date
        
    }
    
    
 
}
