import MapKit
import SwiftUI

struct AirportView: View {
    let airport: Airport

    init(airport: Airport) {
        self.airport = airport
    }

    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .trailing) {
                Text("Airport Details")
                    .font(.largeTitle)
                    .foregroundStyle(.primary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 15)

                DetailItem(label: "Airport Name", value: airport.name)
                Divider()

                DetailItem(label: "Continent", value: airport.continentFullName)
                Divider()

                DetailItem(label: "Municipality", value: airport.municipality)
                Divider()

                DetailItem(label: "Airport Size", value: airport.airportType)
                Divider()

                if airport.home_link != nil && airport.home_link != "" {
                    DetailItem(label: "website", value: airport.home_link ?? "No website found")
                    Divider()
                }
            }
            .containerRelativeFrame(.horizontal) { size, _ in
                size * 0.34
            }

            AiportMap(airport: airport, position: .camera(getCameraView(airport)))
                .clipShape(.rect(cornerRadius: 30))
        }
        .padding(30)
    }

    func getCameraView(_ airport: Airport) -> MapCamera {
        MapCamera(centerCoordinate: airport.location,
                  distance: 3500,
                  heading: 250,
                  pitch: 80)
    }
}

#Preview(windowStyle: .automatic) {
    let airports: [Airport] = Bundle.main.decode("airports-SML.json")

    AirportView(airport: airports[0])
}

struct DetailItem: View {
    let label: String
    let value: String

    var body: some View {
        VStack {
            Text(label)
                .font(.title2)
                .foregroundStyle(.primary)
                .frame(maxWidth: .infinity, alignment: .leading)
            Text(value)
                .font(.title3)
                .foregroundStyle(.secondary)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}
