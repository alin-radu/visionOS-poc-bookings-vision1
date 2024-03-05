//
//  MapView.swift
//  Bookings-poc-visionos1
//
//  Created by Alin RADU on 17.02.2024.
//

import MapKit
import SwiftUI

struct AiportMapView: View {
    let airport: Airport

    @State var position: MapCameraPosition
    @State var satellite = false

    var body: some View {
        Map(position: $position, interactionModes: [.all]) {
            Annotation(airport.name, coordinate: airport.location) {
                Text(airport.name)
                Image(systemName: "mappin.and.ellipse")
                    .font(.largeTitle)
                    .imageScale(.large)
                    .symbolEffect(.pulse)
            }
            .annotationTitles(.hidden)
        }
        .mapStyle(satellite ? .imagery(elevation: .realistic) : .standard(elevation: .realistic))
        .overlay(alignment: .bottomTrailing) {
            Button {
                satellite.toggle()
            } label: {
                Image(systemName: satellite ? "globe.americas.fill" : "globe.americas")
                    .font(.largeTitle)
                    .imageScale(.medium)
                    .padding(3)
                    .shadow(radius: 3)
                    .padding(.horizontal, -20)
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 5)
        }
        .clipShape(.rect(cornerRadius: 30))
    }
}

#Preview(windowStyle: .automatic) {
    let airport = Airports().allAirports[1]

    AiportMapView(airport: airport, position: .camera(MapCamera(centerCoordinate: airport.location,
                                                                distance: 3500,
                                                                heading: 250,
                                                                pitch: 80)))
}
