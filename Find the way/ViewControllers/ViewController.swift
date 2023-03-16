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
    
    private var annotationArray = [MKPointAnnotation]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        addAdressButtonTarget()
        routeButtonTarget()
        resetButtonTarget()
        
        mapView.delegate = self
    }
    
    private func addAdressButtonTarget() {
        addAdressButton.addTarget(self, action: #selector(addAdressButtonTapped), for: .touchUpInside)
    }
    
    private func routeButtonTarget() {
        routeButton.addTarget(self, action: #selector(routeButtonTapped), for: .touchUpInside)
    }
    
    private func resetButtonTarget() {
        resetButton.addTarget(self, action: #selector(resetButtonTapped), for: .touchUpInside)
    }
    
    @objc private func addAdressButtonTapped() {
        alertAddAdress(title: "Next point", placeholder: "Add adress") { [self] text in
            setupPlacemark(adress: text)
        }
    }
    
    @objc private func routeButtonTapped() {
        for index in 0...annotationArray.count - 2 {
            createDirectionRequest(startCoordinate: annotationArray[index].coordinate,
                                   destinationCoordinate: annotationArray[index + 1].coordinate)
        }
        mapView.showAnnotations(annotationArray, animated: true)
    }
    
    @objc private func resetButtonTapped() {
        mapView.removeOverlays(mapView.overlays)
        mapView.removeAnnotations(mapView.annotations)
        annotationArray = [MKPointAnnotation]()
        routeButton.isHidden = true
        resetButton.isHidden = true
        
    }
    
    private func setupPlacemark(adress: String) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(adress) { [self] (placemarks, error) in
            if let error = error {
                print (error)
                alertError(title: "Error!", message: "Something goes wrong(")
            }
            
            guard let placemarks = placemarks else { return }
            let placemark = placemarks.first
            
            let annotation = MKPointAnnotation()
            annotation.title = "\(adress)"
            guard let placemarkLocation = placemark?.location else { return }
            annotation.coordinate = placemarkLocation.coordinate
            
            annotationArray.append(annotation)
            
            if annotationArray.count > 2 {
                routeButton.isHidden = false
                resetButton.isHidden = false
            }
            
            mapView.showAnnotations(annotationArray, animated: true)
        }
    }
    
    private func createDirectionRequest(startCoordinate: CLLocationCoordinate2D, destinationCoordinate: CLLocationCoordinate2D) {
        
        let startLocation = MKPlacemark(coordinate: startCoordinate)
        let destLocation = MKPlacemark(coordinate: destinationCoordinate)
        
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: startLocation)
        request.destination = MKMapItem(placemark: destLocation)
        request.transportType = .automobile
        request.requestsAlternateRoutes = true
        
        let direction  = MKDirections(request: request)
        direction.calculate { (response, error) in
            if let error = error {
                print (error)
                return
            }
            guard let response = response else {
                self.alertError(title: "Error", message: "Route is unavailable")
                return
            }
            
            var shortestRoute = response.routes[0]
            for route in response.routes {
                shortestRoute = (route.distance < shortestRoute.distance) ? route : shortestRoute
            }
            
            self.mapView.addOverlay(shortestRoute.polyline)
        }
    }
}

extension ViewController {
    
    private func configure() {
        
        view.addSubview(mapView)
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor, constant: Constants.ForMapView.boundsOffset),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.ForMapView.boundsOffset),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.ForMapView.boundsOffset),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: Constants.ForMapView.boundsOffset)
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


extension ViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay as! MKPolyline)
        renderer.strokeColor = .red
        return renderer
    }
}
