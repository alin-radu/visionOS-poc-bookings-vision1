import MapKit
import RealityKit
import RealityKitContent
import SwiftUI

struct AirportsView: View {
    @Environment(\.openWindow) private var openWindow

    @Binding var viewModel: ViewModel

    var body: some View {
        NavigationStack {
            HStack {
                // airports list
                ScrollView {
                    Divider()
                    LazyVStack(alignment: .leading) {
                        ForEach(viewModel.filteredAirports) { airport in
                            ListLabel(airport: airport,
                                      selectedAirport: $viewModel.selectedAirport,
                                      openWindow: openWindow
                            )
                        }
                    }
                    .animation(.default, value: viewModel.searchTerm)
                    .animation(.default, value: viewModel.continentSelection)
                }
                .padding(.trailing, 25)
                .containerRelativeFrame(.horizontal) { size, _ in
                    size * 0.5
                }

                // map view
                HStack {
                    if let selectedAirport = viewModel.selectedAirport {
                        AiportMapView(airport: selectedAirport,
                                      position: .camera(.getMapCameraPosition(coordinate: selectedAirport.coordinate, cameraPosition: .standard)))
                    } else {
                        AiportMapView(airport: viewModel.firstFilteredAirport,
                                      position: .camera(.getMapCameraPosition(coordinate: viewModel.firstFilteredAirport.coordinate, cameraPosition: .standard)))
                    }
                }
            }
            .padding([.leading, .bottom, .trailing], 25)
            .searchable(text: $viewModel.searchTerm)
            .autocorrectionDisabled()
            .toolbar {
                ToolBarItems(continentSelection: $viewModel.continentSelection, filteredAirports: viewModel.filteredAirports)
            }
            .navigationDestination(for: Airport.self) { airport in
                AirportDetailsView(airport: airport)
            }
        }
        .onAppear {
            print("---> AirportsContentView | onAppear")
        }
    }
}

#Preview(windowStyle: .automatic) {
    let viewModel = AirportsView.ViewModel()

    AirportsView(viewModel: .constant(viewModel))
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

    let openWindow: OpenWindowAction

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
            .padding(.leading, 20)
            .padding(.vertical, 10)
            .frame(maxWidth: /*@START_MENU_TOKEN@*/ .infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
            .background(.ultraThinMaterial)
            .clipShape(.rect(cornerRadius: 10))
            .onTapGesture {
                print("airport: \(airport.name)")
                selectedAirport = airport
            }

            Spacer()

            NavigationLink(value: airport) {
                Image(systemName: "info")
                    .imageScale(.medium)
                    .help("Airport Details in New Section")
            }

            Button {
                print("open in new window: \(airport.name)")
                openWindow(value: airport.id)
            } label: {
                Image(systemName: "rectangle.portrait.on.rectangle.portrait")
                    .imageScale(.medium)
                    .rotationEffect(.degrees(-90))
                    .help("Airport Details in New Window")
            }
        }

        Divider()
    }
}
