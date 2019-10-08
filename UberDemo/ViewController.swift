//
//  ViewController.swift
//  UberDemo
//
//  Created by abuzeid on 10/6/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import MapKit
import Starscream
import UIKit

class ViewController: UIViewController {
    // MARK: copypaset

    ///

    var socket = WebSocket(url: URL(string: APIConstants.url)!, protocols: [])
    @IBOutlet var mapView: MKMapView!
    @IBOutlet var statusLbl: UILabel!
    var data: EventRespose? {
        didSet {
            updateUI()
        }
    }

    private func updateUI() {
        guard let event = data?.data,
            let pickup = event.pickupLocation,
            let dropoff = event.dropoffLocation,
            let stop = event.intermediateStopLocations else { return }
        // add start
        var polyline: [CLLocationCoordinate2D] = []
        if let lat = pickup.lat,
            let lon = pickup.lng {
            let london = MKPointAnnotation()
            london.title = "Start"
            london.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)

            mapView.addAnnotation(london)
            centerMapOnLocation(location: london.coordinate)
            polyline.append(london.coordinate)
        }

        // add stops

        for point in stop {
            if let lat = point.lat,
                let lon = point.lng {
                let london = MKPointAnnotation()
                london.title = "Break"
                london.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
                mapView.addAnnotation(london)
                polyline.append(london.coordinate)
            }
        }
        // add dropoff
        if let lat = dropoff.lat,
            let lon = dropoff.lng {
            let london = MKPointAnnotation()
            london.title = "End"
            london.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
            mapView.addAnnotation(london)
            polyline.append(london.coordinate)
            drawRoute(points: polyline)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        socket.delegate = self
        socket.connect()
    }

    deinit {
        socket.disconnect(forceTimeout: 0)
        socket.delegate = nil
    }

    func sendMessage(_ message: String) {
        socket.write(string: message)
    }
}

// MARK: - WebSocketDelegate

// MARK: Mapview

extension ViewController {
    func centerMapOnLocation(location: CLLocationCoordinate2D) {
        let regionRadius: CLLocationDistance = 4000
        let coordinateRegion = MKCoordinateRegion(center: location,
                                                  latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }

    func drawRoute(points: [CLLocationCoordinate2D]) {
        let routeLine = MKPolyline(coordinates: points, count: points.count)

        mapView.addOverlay(routeLine)
    }

    func addCar(at: CLLocationCoordinate2D) {
        let london = MKPointAnnotation()
        london.title = "Break"
        london.coordinate = CLLocationCoordinate2D(latitude: at.latitude, longitude: at.longitude)

        mapView.addAnnotation(london)
    }

    func getHeadingForDirection(fromCoordinate fromLoc: CLLocationCoordinate2D, toCoordinate toLoc: CLLocationCoordinate2D) -> Float {
        let fLat: Float = Float(fromLoc.latitude.degreesToRadians)
        let fLng: Float = Float(fromLoc.longitude.degreesToRadians)
        let tLat: Float = Float(toLoc.latitude.degreesToRadians)
        let tLng: Float = Float(toLoc.longitude.degreesToRadians)
        let degree: Float = atan2(sin(tLng - fLng) * cos(tLat), cos(fLat) * sin(tLat) - sin(fLat) * cos(tLat) * cos(tLng - fLng)).radiansToDegrees
        if degree >= 0 {
            return degree
        } else {
            return 360 + degree
        }
    }
}

extension Int {
    var degreesToRadians: Double { return Double(self) * .pi / 180 }
}

extension FloatingPoint {
    var degreesToRadians: Self { return self * .pi / 180 }
    var radiansToDegrees: Self { return self * 180 / .pi }
}

class CarCustomAnnotation: MKPointAnnotation {
    var pinCustomImageName: String!
    var courseDegrees: Double! // Change The Value for Rotating Car Image Position
}

class MarkerAnnotationView: MKAnnotationView {
    override var annotation: MKAnnotation? {
        willSet {
            guard let annotation = newValue as? CarCustomAnnotation else { return }
            image = UIImage(named: annotation.pinCustomImageName)
        }
    }
}

extension ViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else { return nil }
        let identifier = "Annotation"

        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)

        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView!.canShowCallout = true
        } else {
            annotationView!.annotation = annotation
        }

        return annotationView
    }

    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let polylineRenderer = MKPolylineRenderer(overlay: overlay)
        polylineRenderer.strokeColor = UIColor.blue
        polylineRenderer.lineWidth = 5
        return polylineRenderer
    }
}
