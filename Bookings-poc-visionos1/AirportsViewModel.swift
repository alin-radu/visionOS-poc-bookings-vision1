//
//  AiportsContentView-ViewModel.swift
//  Bookings-poc-visionos1
//
//  Created by Alin RADU on 07.03.2024.
//

import SwiftUI

extension AirportsContentView {
    @Observable
    class ViewModel {
        let airports: Airports = Airports()

        var searchTerm: String = ""
        var continentSelection: Continent = Continent.all
        var selectedAirport: Airport?

        var filteredAirports: [Airport] {
            airports.filter(by: continentSelection)
            return airports.search(for: searchTerm)
        }

        var firstFilteredAirport: Airport {
            return filteredAirports[0]
        }
    }
}
