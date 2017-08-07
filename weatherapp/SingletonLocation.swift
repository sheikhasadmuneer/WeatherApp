//
//  SingletonLocation.swift
//  weatherapp
//
//  Created by Asad on 07/08/2017.
//  Copyright © 2017 Asad. All rights reserved.
//

import CoreLocation

class SingletonLocation {
    
    static var singletonLocationObject = SingletonLocation()
    private init () {}
    
    var latitude: Double!
    var longitude: Double!

}
