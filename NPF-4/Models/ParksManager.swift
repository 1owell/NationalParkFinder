//
//  ParksManager.swift
//  NPF-4
//
//  Created by Lowell Pence on 4/23/21.
//

import CoreLocation

class ParksManager: ObservableObject {
    
    var parks: [Park] = []
    
    init() {
        self.parks = loadData() ?? []
    }
    
    
//    func distanceAway(from park: Park, locationManager: LocationManager) -> Double {
//        LocationManager.
//    }
    
    
    private func loadData() -> [Park]? {
        if let path = Bundle.main.path(forResource: "data", ofType: "plist") {
            do {
                // Deserialize plist data in Data object
                let data = try Data(contentsOf: URL(fileURLWithPath: path))
                
                // Serialize data object into a dictionary
                let tempDict = try PropertyListSerialization.propertyList(from: data, format: nil) as! [String : Any]
                
                let tempArray = tempDict["parks"] as! Array<[String : Any]>
                
                var tempParks: [Park] = []
                
                for dict in tempArray {
                    let parkName     = dict["parkName"]! as! String
                    let parkLocation = dict["parkLocation"]! as! String
                    let dateFormed   = dict["dateFormed"]! as! String
                    let area         = dict["area"]! as! String
                    let link         = dict["link"]! as! String
                    let parkDesc     = dict["description"]! as! String
                    
                    let latitude     = Double(dict["latitude"]! as! String)!
                    let longitude    = Double(dict["longitude"]! as! String)!
                    let location     = CLLocation(latitude: latitude, longitude: longitude)
                    
                    let imageLink    = dict["imageLink"]! as! String
                    let imageName    = dict["imageName"]! as! String
                    let imageSize    = dict["imageSize"]! as! String
                    let imageType    = dict["imageType"]! as! String
                    let image        = ParkImage(imageLink: imageLink, imageName: imageName, imageSize: imageSize, imageType: imageType)
                    
                    let p = Park(parkName: parkName, parkLocation: parkLocation, dateFormed: dateFormed, area: area, link: link, location: location, image: image, parkDescription: parkDesc)
                    
                    tempParks.append(p)
                }
                
                return tempParks
            } catch {
                fatalError("Failed to load data from plist")
            }
        }
        
        return nil
    }
}

