//
//  MapView.swift
//  NPF-4
//
//  Created by Lowell Pence
//

import SwiftUI
import MapKit
import CoreLocation

// UIKit MapView
struct MapView: UIViewRepresentable {
    
    @Binding var locationManager: CLLocationManager
    @Binding var showMapAlert: Bool
    @Binding var parks: [Park]
    
    @Binding var mapType: MKMapType
    @Binding var showLoading: Bool
    @Binding var isZoomedToUser: Bool

    let mapView = MKMapView()
    
    func makeUIView(context: Context) -> MKMapView {
        // ask for permission
        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestWhenInUseAuthorization()
        }
        
        // let the location manager and map view know who their coordinator / delegate is
        locationManager.delegate = context.coordinator
        mapView.delegate         = context.coordinator
        
        return mapView
    }
    
    
    func updateUIView(_ view: MKMapView, context: Context) {
        view.showsUserLocation = true
        view.mapType = mapType
    }
    
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    
    class Coordinator: NSObject, MKMapViewDelegate, CLLocationManagerDelegate {
        
        var parent: MapView
        
        init(_ parent: MapView) {
            self.parent = parent
        }
        
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            let identifier = "Park"
            
            if annotation is MKUserLocation {
                return nil
            }
            else if annotation is Park {
                if let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) {
                    annotationView.annotation = annotation
                    return annotationView
                }
                else {
                    
                    let annotationView = MKPinAnnotationView(annotation:annotation, reuseIdentifier:identifier)
                    annotationView.isEnabled      = true
                    annotationView.pinTintColor   = MKPinAnnotationView.purplePinColor()
                    annotationView.animatesDrop   = true
                    annotationView.canShowCallout = true

                    let leftButton  = UIButton(type: .infoLight)
                    let rightButton = UIButton(type: .detailDisclosure)
                    leftButton.tag  = 0
                    rightButton.tag = 1
                  
                    annotationView.leftCalloutAccessoryView  = leftButton
                    annotationView.rightCalloutAccessoryView = rightButton

                    return annotationView
                }
            }
            
            return nil
        }
        
        
        func mapViewDidFinishRenderingMap(_ mapView: MKMapView, fullyRendered: Bool) {
            // Add the map annotations
            for park in parent.parks {
                mapView.addAnnotation(park)
            }
        }
        
        
        func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
            let parkAnnotation = view.annotation as! Park
            switch control.tag {
            case 0: // left button
                if let url = URL(string: parkAnnotation.link) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            case 1: // right button
                // make sure location manager has updated before trying to use
                guard let coordinate = parent.locationManager.location?.coordinate else {
                    return
                }
                let url = String(format: "http://maps.apple.com/maps?saddr=%f,%f&daddr=%f,%f",
                                 coordinate.latitude,
                                 coordinate.longitude,
                                 parkAnnotation.location.coordinate.latitude,
                                 parkAnnotation.location.coordinate.longitude)
                UIApplication.shared.open(URL(string: url)!, options: [:], completionHandler: nil)
            default:
                break
            }
        }
        
        
        func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
            if parent.isZoomedToUser {
                // Zoom in
                let mkCoordinateRegion = MKCoordinateRegion(center: userLocation.coordinate, latitudinalMeters: 20000, longitudinalMeters: 20000)
                mapView.setRegion(mkCoordinateRegion, animated: true)
            } else {
                // Zoom out
                if parent.showLoading {
                    // Button was pressed to initiate this
                    mapView.showAnnotations(mapView.annotations, animated: true)
                }
            }
            parent.showLoading = false
        }
  
        
        // MARK: Location Manager Delegate Methods
        func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
            let status = CLLocationManager.authorizationStatus()
            
            switch status {
                case .restricted:
                    break
                case .denied:
                    parent.showMapAlert.toggle()
                    return
                case .notDetermined:
                    parent.locationManager.requestWhenInUseAuthorization()
                    return
                case .authorizedWhenInUse:
                    return
                case .authorizedAlways:
                    parent.locationManager.allowsBackgroundLocationUpdates = true
                    parent.locationManager.pausesLocationUpdatesAutomatically = false
                    return
                @unknown default:
                    break
            }
        }
    }
}
