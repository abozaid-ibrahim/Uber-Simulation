//
//  Model.swift
//  UberDemo
//
//  Created by abuzeid on 10/8/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import Foundation
//
//extension ViewController: MKMapViewDelegate {
//    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
//        if overlay is MKPolyline {
//            let polylineRenderer = MKPolylineRenderer(overlay: overlay)
//            polylineRenderer.strokeColor = UIColor.blue
//            polylineRenderer.lineWidth = 4.0
//            return polylineRenderer
//        }
//        return MKOverlayRenderer()
//    }
//
//    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier)
//        if annotationView == nil {
//            annotationView = MKAnnotationView(annotation: annotationView?.annotation, reuseIdentifier: reuseIdentifier)
//            annotationView?.canShowCallout = false
//        } else {
//            annotationView?.annotation = annotation
//            annotationView?.canShowCallout = false
//        }
//        annotationView?.image = #imageLiteral(resourceName: "car95")
//        return annotationView
//    }
//
//    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
//        // Set PolyLine Between Source and Destinattion
//        let polyline = MKPolyline(coordinates: [sourceCoordinate!, destinationCoordinate!], count: 2)
//        mapView.addOverlay(polyline)
//        pointAnnotation.courseDegrees = getHeadingForDirectionFromCoordinate(sourceCoordinate!, toLoc: destinationCoordinate!)
//        view.transform = CGAffineTransform(rotationAngle: CGFloat(pointAnnotation.courseDegrees))
//        moveCar(destinationCoordinate!)
//    }
//
//    // Insert Animation Duration and Destination Coordinate which you are getting from server.
//    func moveCar(_ destinationCoordinate: CLLocationCoordinate2D) {
//        UIView.animate(withDuration: 20, animations: {
//            self.pointAnnotation.coordinate = destinationCoordinate
//        }, completion: { success in
//            if success {
//                // handle a successfully ended animation
////                self.resetCarPosition()
//            } else {
//                // handle a canceled animation, i.e move to destination immediately
//                self.pointAnnotation.coordinate = destinationCoordinate
//            }
//        })
//    }
//
//    func resetCarPosition(loc: CLLocationCoordinate2D) {
//        pointAnnotation.courseDegrees = 0.0
//        mapView.removeOverlay(mapView.overlays[0])
//        pinAnnotationView.transform = CGAffineTransform(rotationAngle: CGFloat(pointAnnotation.courseDegrees))
//        pointAnnotation.coordinate = loc
//    }
//}
