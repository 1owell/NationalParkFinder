//
//  Landmark.swift
//  FavoritePlaces
//
//  Created by Bryan French on 7/31/15.
//  Copyright (c) 2015 Bryan French. All rights reserved.
//

import Foundation
import CoreLocation
import MapKit

class Landmark: NSObject, MKAnnotation {
    var name  = ""
    var state = ""
    var location : CLLocation?
    //needed for the MKAnnotation protocol
    var coordinate: CLLocationCoordinate2D {
        get {
            return location!.coordinate
        }
    }
    override var description : String {
        return "{\n\t Landmark Name: \(name)\n\t State: \(state)\n\t location: \(String(describing: location))\n}"
    }
    
    init(name: String, state: String, location: CLLocation) {
        self.name = name
        self.state = state
        self.location = location
    }
    
    //optional - required with set callout true
    var title : String? {
        get {
            return name
        }
    }
    
   var subtitle : String? {
        get {
            return state
        }
    }


}
