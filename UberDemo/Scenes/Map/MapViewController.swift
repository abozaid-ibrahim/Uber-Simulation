//
//  MapViewController.swift
//  UberSimulation
//
//  Created by Abuzeid ibrahim on 9/24/19.
//  Copyright © 2019 Abuzeid Mac. All rights reserved.
//

import UIKit
import MapKit
import RxSwift
import RxCocoa
import Action

class MapViewController: UIViewController {

	// MARK: - Properties
	// MARK: Outlets
	@IBOutlet private weak var mapView: MKMapView!
	@IBOutlet private weak var bookRideButton: UIButton!
	@IBOutlet private weak var bookingStatusView: UIView!
	@IBOutlet private weak var bookingStatusLabel: UILabel!

	// MARK: Annotations
	private lazy var vehicleAnnotation = VehicleAnnotation()
	private lazy var pickupAnnotation = MKPointAnnotation()
	private lazy var dropOffAnnotation = MKPointAnnotation()
	private lazy var intermediateStopsAnnotations = [MKPointAnnotation]()

	// MARK: Dependencies
	var viewModel: MapViewModelType!
	private let disposeBag = DisposeBag()

	// MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()

		setupMapView()
		configureBinding()
    }

	func setupMapView() {
		mapView.register(MKMarkerAnnotationView.self)
		mapView.register(VehicleAnnotationView.self)
	}

	/// Configures the binding to the viewModel
	private func configureBinding() {
		bookRideButton.rx.bind(to: viewModel.bookRide, input: ())

		bindBookingStatus()
		bindPickupAndDropOffLocations()
		bindVehicleLocation()
		bindIntermediateStopLocations()
	}

	/// Binds the status of the booking to the UI components
	private func bindBookingStatus() {
		viewModel
			.bookingStatus
			// Checking if the there's a current booking status
			.map { $0 != nil }
			// bind to the UI components
			.bind { [weak self] (isExecuting) in
				guard let self = self else { return }
				UIView.animate(withDuration: 0.15, delay: 0, options: [.curveEaseOut], animations: {
					self.bookingStatusView.transform = CGAffineTransform.identity.translatedBy(x: 0, y: isExecuting ? 0 : self.bookingStatusView.frame.height)
				})
			}
			.disposed(by: disposeBag)

		viewModel
			.bookingStatus
			// get the display text of the current booking status or if the status is not determined then the user is currently booking a ride
			.map { $0?.displayText }
			// Drive on the main thread
			.asDriver(onErrorJustReturn: nil)
			// bind the to the status text
			.drive(bookingStatusLabel.rx.text)
			.disposed(by: disposeBag)
	}

	/// Handles updating the pickup and drop off locations on the map
	private func bindPickupAndDropOffLocations() {
		Observable
			.combineLatest(viewModel.pickupLocation, viewModel.dropOffLocation)
			.asDriver(onErrorJustReturn: (nil, nil))
			.drive(onNext: { [mapView, pickupAnnotation, dropOffAnnotation] (pickupLocation, dropOffLocation) in
				if let pickupLocation = pickupLocation {
					pickupAnnotation.coordinate = CLLocationCoordinate2D(location: pickupLocation)
					pickupAnnotation.title = pickupLocation.address
					mapView?.addAnnotation(pickupAnnotation)
				} else {
					mapView?.removeAnnotation(pickupAnnotation)
				}

				if let dropOffLocation = dropOffLocation {
					dropOffAnnotation.coordinate = CLLocationCoordinate2D(location: dropOffLocation)
					dropOffAnnotation.title = dropOffLocation.address
					mapView?.addAnnotation(dropOffAnnotation)
				} else {
					mapView?.removeAnnotation(dropOffAnnotation)
				}
				mapView?.fitAll(animated: false)
			}).disposed(by: disposeBag)
	}

	/// Handles updating the vehicle's location on the map
	private func bindVehicleLocation() {
		viewModel
			.vehicleLocation
			.asDriver(onErrorJustReturn: nil)
			.drive(onNext: { [weak self] (vehicleLocation) in
				guard let self = self else { return }
				if let vehicleLocation = vehicleLocation {
					self.mapView.addAnnotation(self.vehicleAnnotation)
					UIView.animate(withDuration: 1.5, animations: {
						self.vehicleAnnotation.coordinate = CLLocationCoordinate2D(location: vehicleLocation)
						self.vehicleAnnotation.bearing = vehicleLocation.bearing
						self.mapView.fitAll(animated: true)
					})
				} else {
					self.mapView.removeAnnotation(self.vehicleAnnotation)
					self.mapView.fitAll(animated: false)
				}
			}).disposed(by: disposeBag)
	}

	/// Handles updating the intermediate stop locations on the map
	private func bindIntermediateStopLocations() {
		viewModel
			.intermediateStopLocations
			.asDriver(onErrorJustReturn: [])
			.drive(onNext: { [weak self] (intermediateStopLocations) in
				guard let self = self else { return }
				self.mapView.removeAnnotations(self.intermediateStopsAnnotations)
				self.intermediateStopsAnnotations = intermediateStopLocations.map { location in
					let annotation = MKPointAnnotation()
					annotation.coordinate = CLLocationCoordinate2D(location: location)
					annotation.title = location.address
					return annotation
				}
				self.mapView.addAnnotations(self.intermediateStopsAnnotations)
			}).disposed(by: disposeBag)
	}
}

// MARK: - MKMapViewDelegate
extension MapViewController: MKMapViewDelegate {

	func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {

		// dequeue the appropriate annotation view according to the type of annotation
		let annotationView: MKAnnotationView
		if annotation === vehicleAnnotation {
			let view: VehicleAnnotationView = mapView.dequeueReusableAnnotationView(for: annotation)
			annotationView = view
		} else {
			let view: MKMarkerAnnotationView = mapView.dequeueReusableAnnotationView(for: annotation)
			view.canShowCallout = true
			annotationView = view
		}

		// Set the display priority as required to prevent the annotation from disappearing
		annotationView.displayPriority = .required
		return annotationView
	}
}

// MARK: - StoryboardLoadable
extension MapViewController: StoryboardLoadable { }
