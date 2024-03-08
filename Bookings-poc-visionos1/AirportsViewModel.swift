import SwiftUI

extension AirportsView {
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
