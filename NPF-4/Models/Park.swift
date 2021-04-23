//
//  Park.swift
//  NPF-2
//
//  Created by Lowell Pence on 3/7/21.
//

import Foundation
import CoreLocation
import MapKit

struct ParkImage {
    let imageLink: String?
    let imageName: String?
    let imageSize: String?
    let imageType: String?
    
    var description: String {
        """
        imageLink: \(imageLink ?? "")
        \timageName: \(imageName ?? "")
        \timageSize: \(imageSize ?? "")
        \timageType: \(imageType ?? "")
        """
    }
}

extension ParkImage {
    init() {
        self.imageLink = nil
        self.imageName = nil
        self.imageSize = nil
        self.imageType = nil
    }
}

class Park: NSObject, MKAnnotation {
    
    private var _parkName: String        = ""
    private var _parkLocation: String    = ""
    private var _dateFormed: String      = ""
    private var _area: String            = ""
    private var _link: String            = ""
    
    private var _location: CLLocation
    private var _image: ParkImage?       = nil
    private var _parkDescription: String = ""
    
    var title: String? { parkName }
    var subtitle: String? { parkLocation }
    
    var parkName: String {
        get { self._parkName }
        set {
            let stripped = newValue.trimmingCharacters(in: .whitespacesAndNewlines)
            if (stripped.count > 3 && stripped.count < 75) {
                self._parkName = stripped
            } else {
                self._parkName = "TBD"
                print("Bad value of \(newValue) in set(parkName): setting to TBD")
            }
        }
    }
    
    var parkLocation: String {
        get { self._parkLocation }
        set {
            let stripped = newValue.trimmingCharacters(in: .whitespacesAndNewlines)
            if (stripped.count > 3 && stripped.count < 75) {
                self._parkLocation = stripped
            } else {
                self._parkLocation = "TBD"
                print("Bad value of \(newValue) in set(location): setting to TBD")
            }
        }
    }
    
    var dateFormed: String {
        get { self._dateFormed }
        set { self._dateFormed = newValue }
    }
    
    var area: String {
        get { self._area }
        set { self._area = newValue }
    }
    
    var link: String {
        get { self._link }
        set { self._link = newValue }
    }
    
    var location: CLLocation {
        get { self._location }
        set { self._location = newValue }
    }
    
    var image: ParkImage? {
        get { self._image }
        set { self._image = newValue }
    }

    var parkDescription: String {
        get { self._parkDescription }
        set { self._parkDescription = newValue }
    }
    
    var coordinate: CLLocationCoordinate2D
    // subtitle and title properties needed or not?
    
    override var description: String {
        """
        {
            parkName: \(parkName)
            parkLocation: \(parkLocation)
            dateFormed: \(dateFormed)
            area: \(area)
            link: \(link)
            location: \(location.description)
            \(image?.description ?? "No image")
            parkDescription: \(parkDescription)
        }
        """
    }
    
    init(parkName: String, parkLocation: String, dateFormed: String, area: String, link: String, location: CLLocation, image: ParkImage?, parkDescription: String) {
        
        self.coordinate      = location.coordinate
        self._location       = location

        super.init()
        
        self.parkName        = parkName
        self.parkLocation    = parkLocation
        self.dateFormed      = dateFormed
        self.area            = area
        self.link            = link
        self.image           = image
        self.parkDescription = parkDescription
    }
}
