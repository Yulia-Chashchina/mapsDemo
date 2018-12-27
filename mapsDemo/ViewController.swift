//
//  ViewController.swift
//  mapsDemo
//
//  Created by Юлия Чащина on 27/12/2018.
//  Copyright © 2018 Yulia Chashchina. All rights reserved.
//

import UIKit
import GoogleMaps

class VacationDestination: NSObject {
    let name: String
    let location: CLLocationCoordinate2D
    let zoom: Float
    
    init(name: String, location: CLLocationCoordinate2D, zoom: Float ) {
        self.name = name
        self.location = location
        self.zoom = zoom
    }
}


class ViewController: UIViewController {
    
    var mapView: GMSMapView?
    var currentDestination: VacationDestination?
    let destinations = [VacationDestination(name: "Embarcadero Station", location: CLLocationCoordinate2D(latitude: 37.793092, longitude: -122.397048), zoom: 15), VacationDestination(name: "Ferry Building", location: CLLocationCoordinate2D(latitude: 37.795808, longitude: -122.393299), zoom: 18)]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        GMSServices.provideAPIKey("INSERT_YOUR_API_KEY_HERE")

        let camera = GMSCameraPosition.camera(withLatitude: 37.621292, longitude: -122.379020, zoom: 10)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view = mapView
        
        let currentLocation = CLLocationCoordinate2D(latitude: 37.621292, longitude: -122.379020)
        let marker = GMSMarker(position: currentLocation)
        marker.title = "SFO Airport"
        marker.map = mapView
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: (#selector(ViewController.next as (ViewController) -> () -> ())))

    }
    
    @objc func next() {
        
        if currentDestination == nil {
            currentDestination = destinations.first
        }else {
            if let index = destinations.index(of: currentDestination!) {
            currentDestination = destinations[index + 1]
            }
        }
        setMapCamera()
    }
    
    private func setMapCamera() {
        CATransaction.begin()
        CATransaction.setValue(2, forKey: kCATransactionAnimationDuration)
        mapView?.animate(to: GMSCameraPosition.camera(withTarget: currentDestination!.location, zoom: currentDestination!.zoom))
        CATransaction.commit()
        
        let marker = GMSMarker(position: currentDestination!.location)
        marker.title = currentDestination!.name
        marker.map = mapView
    }


}

