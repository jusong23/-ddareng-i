//
//  ViewController.swift
//  nenetwork
//
//  Created by 이주송 on 2022/08/08.
//

import UIKit
import CoreLocation
import NMapsMap


class ViewController: UIViewController, CLLocationManagerDelegate {
    
    var locationManager = CLLocationManager()
    
    @IBAction func tapSearchButton(_ sender: Any) {
        guard let viewController = self.storyboard?.instantiateViewController(withIdentifier: "SearchViewController") as? SearchViewController else {return}
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let mapView = NMFMapView(frame: view.frame)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(mapView)

        mapView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        mapView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        mapView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        mapView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
         
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            print("위치 서비스 On 상태")
            locationManager.startUpdatingLocation()
            print(locationManager.location?.coordinate)
            
            //현 위치로 카메라 이동
            let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: locationManager.location?.coordinate.latitude ?? 0, lng: locationManager.location?.coordinate.longitude ?? 0))
            cameraUpdate.animation = .easeIn
            mapView.moveCamera(cameraUpdate)
            
            //Marker 표시
            let marker = NMFMarker()
            marker.position = NMGLatLng(lat: locationManager.location?.coordinate.latitude ?? 0, lng: locationManager.location?.coordinate.longitude ?? 0)
            marker.width = 25
            marker.height = 35
            marker.captionColor = UIColor.red
            marker.captionText = "10"
            marker.mapView = mapView
            
            let marker2 = NMFMarker()
            marker2.position = NMGLatLng(lat: 37.6215, lng: 127.0598)
            marker2.width = 25
            marker2.height = 35
            marker2.captionColor = UIColor.red
            marker2.captionText = "13"
            marker2.mapView = mapView
            
        } else {
            print("위치 서비스 Off 상태")
        }

    }
    
    
    
    
    
}
