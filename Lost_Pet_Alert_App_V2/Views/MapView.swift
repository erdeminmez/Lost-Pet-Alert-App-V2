//
//  MapView.swift
//  Lost_Pet_Alert_App_V2
//
//  Created by Erdem Inmez on 2022-12-10.
//

import SwiftUI
import MapKit

struct MapView: View {
    @EnvironmentObject var locationHelper : LocationHelper
    @EnvironmentObject var fireDBHelper : FireDBHelper
    let selectedAlertIndex : Int
    
    var body: some View {
        VStack{
            if (self.locationHelper.currentLocation != nil){

                MyMap(location: self.locationHelper.currentLocation!)
            }else{
                Text("No Location available")
            }
        }
        .onAppear(){
            let address = "\(self.fireDBHelper.disappearanceAlertList[selectedAlertIndex].dspStreet), \(self.fireDBHelper.disappearanceAlertList[selectedAlertIndex].dspCity), \(self.fireDBHelper.disappearanceAlertList[selectedAlertIndex].dspCountry)"
            
            self.locationHelper.doForwardGeocoding(address: address)
            
            
        }
    }//body
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(selectedAlertIndex: 0)
    }
}


struct MyMap : UIViewRepresentable{
    typealias UIViewType = MKMapView
    
    private var location: CLLocation
    @EnvironmentObject var locationHelper : LocationHelper
    
    init(location: CLLocation) {
        self.location = location
    }
    
    func makeUIView(context: Context) -> MKMapView{
        let sourceCordinates : CLLocationCoordinate2D
        let region : MKCoordinateRegion
        
        if (self.locationHelper.currentLocation != nil){
            sourceCordinates = self.locationHelper.currentLocation!.coordinate
        }else{
            sourceCordinates = CLLocationCoordinate2D(latitude: 43.642566, longitude: -79.38762)
        }
        
        let span = MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
        region = MKCoordinateRegion(center: sourceCordinates, span: span)
        
        let map = MKMapView()
        
        map.mapType = MKMapType.hybrid
        map.setRegion(region, animated: true)
        map.showsUserLocation = true
        map.isZoomEnabled = true
        map.isScrollEnabled = true
        
        return map
        
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        print(#function, "Trying to update MyMap")
        
        let sourceCordinates : CLLocationCoordinate2D
        let region : MKCoordinateRegion
        
        if (self.locationHelper.currentLocation != nil){
            sourceCordinates = self.locationHelper.currentLocation!.coordinate
        }else{
            sourceCordinates = CLLocationCoordinate2D(latitude: 43.642566, longitude: -79.38762)
        }
        
        let span = MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
        region = MKCoordinateRegion(center: sourceCordinates, span: span)
        
        uiView.setRegion(region, animated: true)
        self.locationHelper.addPinToMap(mapView: uiView, coordinates: sourceCordinates)
        
    }
    
    
}

