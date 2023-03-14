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
    
    private let mapView: MKMapView = {
       let map = MKMapView()
        map.translatesAutoresizingMaskIntoConstraints = false
        return map
    }()
    
    private let addAdressButton: UIButton = {
       let button = UIButton()
        button.setTitle("addAdressButton", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let routeButton: UIButton = {
       let button = UIButton()
        button.setTitle("routeButton", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let resetButton:UIButton = {
       let button = UIButton()
        button.setTitle("resetButton", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
    
        setConstraints()
        addAdressButtonTarget()
        routeButtonTarget()
        resetButtonTarget()
    }
    
    private func addAdressButtonTarget() {
        addAdressButton.addTarget(self, action: #selector(addAdressButtonTapped), for: .touchUpInside)
    }
    
    private func routeButtonTarget() {
        addAdressButton.addTarget(self, action: #selector(routeButtonTapped), for: .touchUpInside)
    }
    
    private func resetButtonTarget() {
        addAdressButton.addTarget(self, action: #selector(reseetButtonTapped), for: .touchUpInside)
    }
    
    @objc func addAdressButtonTapped() {
        
    }
    
    @objc func routeButtonTapped() {
        
    }
    
    @objc func reseetButtonTapped() {
        
    }
}


extension ViewController {
    
    private func setConstraints() {
        
        view.addSubview(mapView)
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
}

