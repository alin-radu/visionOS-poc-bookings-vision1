import MapKit
import RealityKit
import RealityKitContent
import SwiftUI

struct ContentView: View {
    let airports: Airports = Airports()

    @State var searchTerm: String = ""
    @State var continentSelection: Continent = Continent.all
    @State var selectedAirport: Airport?
    @State var selectedMapPosition: CLLocationCoordinate2D?

    var filteredAirports: [Airport] {
        airports.filter(by: continentSelection)

        return airports.search(for: searchTerm)
    }

    var firstFilteredAirport: Airport {
        return filteredAirports[0]
    }

    var body: some View {
        NavigationStack {
            HStack {
                // airports list
                ScrollView {
                    Divider()
                    LazyVStack(alignment: .leading) {
                        ForEach(filteredAirports) { airport in

                            ListLabel(airport: airport,
                                      selectedAirport: $selectedAirport,
                                      selectedMapPosition: $selectedMapPosition)
                        }
                    }
                    .animation(.default, value: searchTerm)
                    .animation(.default, value: continentSelection)
                }
                .padding(.trailing, 25)
                .containerRelativeFrame(.horizontal) { size, _ in
                    size * 0.5
                }

                // map view
                HStack {
                    if let selectedAirport {
                        AiportMapView(airport: selectedAirport, position: .camera(MapCamera(centerCoordinate: selectedMapPosition!,
                                                                                        distance: 5000,
                                                                                        heading: 250,
                                                                                        pitch: 80)))
                    } else {
                        AiportMapView(airport: airports.displayedAirports[0],
                                  position: .camera(MapCamera(centerCoordinate: airports.displayedAirports[0].location,
                                                              distance: 5000,
                                                              heading: 250,
                                                              pitch: 80)))
                    }
                }
            }
            .padding([.leading, .bottom, .trailing], 25)
            .searchable(text: $searchTerm)
            .autocorrectionDisabled()
            .toolbar {
                ToolBarItems(continentSelection: $continentSelection, filteredAirports: filteredAirports)
            }
            .navigationDestination(for: Airport.self) { airport in
                AirportView(airport: airport)
            }
        }
        .onAppear {
            print("onAppear ---> ")
        }
    }

    func getCameraView(_ airport: Airport) -> MapCamera {
        MapCamera(centerCoordinate: airport.location,
                  distance: 3500,
                  heading: 250,
                  pitch: 80)
    }
}

#Preview(windowStyle: .automatic) {
    ContentView()
}

// components

struct ToolBarItems: ToolbarContent {
    @Binding var continentSelection: Continent
    var filteredAirports: [Airport]

    var body: some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            Text("Airports List")
                .font(.largeTitle)
                .foregroundStyle(.primary)
                +
                Text("   \(filteredAirports.count) locations")
                .foregroundStyle(.secondary)
        }
        ToolbarItem(placement: .topBarTrailing) {
            Text(continentSelection.name)
        }
        ToolbarItem(placement: .topBarTrailing) {
            Menu {
                Picker("Filter", selection: $continentSelection.animation()) {
                    ForEach(Continent.allCases) { continent in
                        Text(continent.name)
                    }
                }
            } label: {
                Image(systemName: "list.bullet.rectangle.fill")
            }
        }
    }
}

struct ListLabel: View {
    let airport: Airport

    @Binding var selectedAirport: Airport?
    @Binding var selectedMapPosition: CLLocationCoordinate2D?

    var body: some View {
        HStack {
            
            VStack(alignment: .leading) {
                Text(airport.name)
                    .font(.title2)
                    .foregroundStyle(.primary)
                Text("\(airport.municipality)")
                    .font(.title3)
                    .foregroundStyle(.secondary)
            }

            Spacer()
            
            NavigationLink(value: airport) {
                Image(systemName: "info")
                    .imageScale(.medium)
            }

            Button {
                print(airport.name)
                selectedAirport = airport
                selectedMapPosition = airport.location
            } label: {
                Image(systemName: "map")
                    .imageScale(.medium)
            }
        }
        Divider()
    }
}
