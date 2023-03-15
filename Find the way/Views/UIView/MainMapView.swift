//
//  MainMapView.swift
//  Find the way
//
//  Created by Andrei Sushkou on 15.03.23.
//

import UIKit
import MapKit


final class MainMapView: UIView {
    
    private enum Constants {
        enum ForMapView {
            static let boundsOffset: CGFloat = 0
        }
        
        enum ForAddAdressButton {
            static let top: CGFloat = 60
            static let trailing: CGFloat = -20
            static let widthAndHeight: CGFloat = 70
        }
        
        enum ForRouteButton {
            static let leading: CGFloat = 40
            static let bottom: CGFloat = -65
            static let widthAndHeight: CGFloat = 60
        }
        
        enum ForResetButton {
            static let trailing: CGFloat = -20
            static let bottom: CGFloat = -65
            static let widthAndHeight: CGFloat = 60
        }
    }
    
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
//        button.isHidden = true
        return button
    }()
    
    private let resetButton:UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "resetButton"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
//        button.isHidden = true
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        setConstraints()
        addAdressButtonTarget()
        routeButtonTarget()
        resetButtonTarget()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
        private func addAdressButtonTarget() {
            addAdressButton.addTarget(self, action: #selector(addAdressButtonTapped), for: .touchUpInside)
        }
    
        private func routeButtonTarget() {
            routeButton.addTarget(self, action: #selector(routeButtonTapped), for: .touchUpInside)
        }
    
        private func resetButtonTarget() {
            resetButton.addTarget(self, action: #selector(reseetButtonTapped), for: .touchUpInside)
        }
    
        @objc func addAdressButtonTapped() {
            print ("Adress")
        }
    
        @objc func routeButtonTapped() {
            print ("Route")
        }
    
        @objc func reseetButtonTapped() {
            print ("Reset")
        }
}


extension MainMapView {
    
    private func setConstraints() {
        
        addSubview(mapView)
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: Constants.ForMapView.boundsOffset),
            mapView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: Constants.ForMapView.boundsOffset),
            mapView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: Constants.ForMapView.boundsOffset),
            mapView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: Constants.ForMapView.boundsOffset)
        ])
        
        mapView.addSubview(addAdressButton)
        NSLayoutConstraint.activate([
            addAdressButton.topAnchor.constraint(equalTo: mapView.topAnchor, constant: Constants.ForAddAdressButton.top),
            addAdressButton.trailingAnchor.constraint(equalTo: mapView.trailingAnchor, constant: Constants.ForAddAdressButton.trailing),
            addAdressButton.heightAnchor.constraint(equalToConstant: Constants.ForAddAdressButton.widthAndHeight),
            addAdressButton.widthAnchor.constraint(equalToConstant: Constants.ForAddAdressButton.widthAndHeight)
        ])
        
        mapView.addSubview(routeButton)
        NSLayoutConstraint.activate([
            routeButton.leadingAnchor.constraint(equalTo: mapView.leadingAnchor, constant: Constants.ForRouteButton.leading),
            routeButton.bottomAnchor.constraint(equalTo: mapView.bottomAnchor, constant: Constants.ForRouteButton.bottom),
            routeButton.heightAnchor.constraint(equalToConstant: Constants.ForRouteButton.widthAndHeight),
            routeButton.widthAnchor.constraint(equalToConstant: Constants.ForRouteButton.widthAndHeight)
        ])
        
        mapView.addSubview(resetButton)
        NSLayoutConstraint.activate([
            resetButton.trailingAnchor.constraint(equalTo: mapView.trailingAnchor, constant: Constants.ForResetButton.trailing),
            resetButton.bottomAnchor.constraint(equalTo: mapView.bottomAnchor, constant: Constants.ForResetButton.bottom),
            resetButton.heightAnchor.constraint(equalToConstant: Constants.ForResetButton.widthAndHeight),
            resetButton.widthAnchor.constraint(equalToConstant: Constants.ForResetButton.widthAndHeight)
        ])
    }
}

