//
//  ViewController.swift
//  Find the way
//
//  Created by Andrei Sushkou on 14.03.23.
//

import UIKit
import MapKit
import CoreLocation


final class ViewController: UIViewController {
    
    
    override func loadView() {
        super.loadView()
        view = MainMapView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
