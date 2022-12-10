//
//  LocationHelper.swift
//  Lost_Pet_Alert_App_V2
//
//  Created by Erdem Inmez on 2022-12-10.
//

import Foundation
import CoreLocation
import Contacts
import MapKit

class LocationHelper : NSObject, ObservableObject{
    
    
    private let geocoder = CLGeocoder()
    
    @Published var currentLocation : CLLocation?
    
    
    override init() {
        super.init()
    }
    
    
    
    func doForwardGeocoding(address : String){
        
        self.geocoder.geocodeAddressString(address, completionHandler: { (placemarks, error) in
//            CLPlacemark
            
            if (error != nil){
                print(#function, "Unable to perform forward geocoding : \(error?.localizedDescription)")
            }else{
                if let placemark = placemarks?.first {
                    
                    let obtainedLocation = placemark.location!
                    self.currentLocation = obtainedLocation
                    print(#function, "Obtained location after forward geocoding : \(obtainedLocation)")
                    
                    
                }else{
                    self.currentLocation = nil
                    print(#function, "Unable to obtain placemark for forward geocoding")
                }
            }
        })
        
    }
    
    func addPinToMap(mapView: MKMapView, coordinates : CLLocationCoordinate2D){
        
        let mapAnnotation = MKPointAnnotation()
        mapAnnotation.coordinate = coordinates
        mapAnnotation.title = "Disappearance Point"
        mapView.removeAnnotations(mapView.annotations)
        mapView.addAnnotation(mapAnnotation)
    }
}
