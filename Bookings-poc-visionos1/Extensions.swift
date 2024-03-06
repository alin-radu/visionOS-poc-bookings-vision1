//
//  Extensions.swift
//  Bookings-poc-visionos1
//
//  Created by Alin RADU on 06.03.2024.
//
import MapKit
import SwiftUI

extension MapCamera {
    static func getDefaultMapCameraPosition(coordinate: CLLocationCoordinate2D) -> MapCamera {
        return MapCamera(centerCoordinate: coordinate,
                         distance: 1500,
                         heading: 250,
                         pitch: 80)
    }
}
