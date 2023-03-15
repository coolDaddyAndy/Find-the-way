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
        button.setImage(UIImage(named: "addAdressButton"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let routeButton: UIButton = {
       let button = UIButton()
        button.setImage(UIImage(named: "routeButton"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = true
        return button
    }()
    
    private let resetButton:UIButton = {
       let button = UIButton()
        button.setImage(UIImage(named: "resetButton"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = true
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
        print ("addAdressButtonTapped")
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
        
        mapView.addSubview(addAdressButton)
        NSLayoutConstraint.activate([
            addAdressButton.topAnchor.constraint(equalTo: mapView.topAnchor, constant: 60),
            addAdressButton.trailingAnchor.constraint(equalTo: mapView.trailingAnchor, constant: -20),
            addAdressButton.heightAnchor.constraint(equalToConstant: 70),
            addAdressButton.widthAnchor.constraint(equalToConstant: 70)
        ])
        
        mapView.addSubview(routeButton)
        NSLayoutConstraint.activate([
           routeButton.leadingAnchor.constraint(equalTo: mapView.leadingAnchor, constant: 40),
           routeButton.bottomAnchor.constraint(equalTo: mapView.bottomAnchor, constant: -65),
           routeButton.heightAnchor.constraint(equalToConstant: 60),
           routeButton.widthAnchor.constraint(equalToConstant: 60)
        ])
        
        mapView.addSubview(resetButton)
        NSLayoutConstraint.activate([
          resetButton.trailingAnchor.constraint(equalTo: mapView.trailingAnchor, constant: -20),
          resetButton.bottomAnchor.constraint(equalTo: mapView.bottomAnchor, constant: -65),
          resetButton.heightAnchor.constraint(equalToConstant: 60),
          resetButton.widthAnchor.constraint(equalToConstant: 60)
        ])
        
    }
}

