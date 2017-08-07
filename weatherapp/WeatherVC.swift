//
//  WeatherVC.swift
//  weatherapp
//  Created by Asad on 04/08/2017.
//  Copyright © 2017 Asad. All rights reserved.
//

import UIKit
import Alamofire
import CoreLocation

class WeatherVC: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var currentWeatherImg: UIImageView!
    
    @IBOutlet weak var currentWeatherLbl: UILabel!
    @IBOutlet weak var locationLbl: UILabel!
    @IBOutlet weak var currentTempLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    
    var locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    var weather: Weather!
    var foreCast: Forecast!
    var forecastsArary = [Forecast]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        weather = Weather()
     
        
    }
    
    
    // runs before viewDidLoad ()
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        //locationManager = CLLocationManager()

        checkIfLocationAuthorize()
    }
    
    func checkIfLocationAuthorize() {
         //locationManager = CLLocationManager()
        
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
                // get location then get cordinates 
            currentLocation = locationManager.location
            // sets value of location
            SingletonLocation.singletonLocationObject.latitude = currentLocation.coordinate.latitude
            SingletonLocation.singletonLocationObject.longitude = currentLocation.coordinate.longitude
            
            // call API
            weather.downloadWeatherData {
            
                self.downloadForecastData {
                    self.updateUI()
                }
                
                
            }
            
            
        } else {
            
            // if not authorized , it will provide a popup
            locationManager.requestWhenInUseAuthorization()
            checkIfLocationAuthorize()
        }
        
    }
    
    func updateUI() {
        
        dateLbl.text = weather.date
        locationLbl.text = weather.cityName
        currentWeatherLbl.text = weather.weatherType
        currentTempLbl.text = "\(weather.currentTemp)"
        currentWeatherImg.image = UIImage(named: weather.weatherType)
    }
    
    func downloadForecastData(complete: @escaping DownloadComplete){
       
        Alamofire.request(FORECAST_URL,method: .get)
            .responseJSON{ (response) in
                
                if let dict = response.result.value as? Dictionary<String, AnyObject> {
                    
                    if let list = dict["list"] as? [Dictionary<String, AnyObject>] {
                        
                        for obj in list {
                            let forecast = Forecast(weatherForecastDict: obj)
                                self.forecastsArary.append(forecast)
                            
                        }
                        self.forecastsArary.remove(at: 0) // removes today's date from array
                        self.tableView.reloadData()       // to reload data in tableView
                    }
                    complete()

                }
        }
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecastsArary.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell", for: indexPath) as? WeatherCell {
            
            let singleForecastRow = forecastsArary[indexPath.row]
            
            cell.configureCell(forecast: singleForecastRow)
        
            return cell
            
            
        } else {
            return WeatherCell()
        }
        
        
     
        
    }
    

}

