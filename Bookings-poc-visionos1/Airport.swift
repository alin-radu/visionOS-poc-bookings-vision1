import MapKit
import SwiftUI

struct Airport: Codable, Identifiable, Equatable, Hashable {
    let id: Int
    let ident: String?
    let type: String
    let name: String
    let latitude_deg: String
    let longitude_deg: String
    let elevation_ft: Int?
    let continent: String?
    let iso_country: String?
    let iso_region: String?
    let municipality: String
    let scheduled_service: String?
    let gps_code: String?
    let iata_code: String?
    let local_code: String?
    let home_link: String?
    let wikipedia_link: String?

    var location: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: (latitude_deg as NSString).doubleValue, longitude: (longitude_deg as NSString).doubleValue)
    }

    var continentFullName: String {
        Continent.getContinentName(for: continent)
    }

    var airportType: String {
        switch type {
        case "small_airport":
            "Small Airport"
        case "medium_airport":
            "Medium Airport"
        case "large_airport":
            "Large Airport"
        default:
            "Unknown Airport Type"
        }
    }
}
