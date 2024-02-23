import RealityKit
import RealityKitContent
import SwiftUI

struct ContentView: View {
    let airports = Airports()

    @State var searchTerm = ""
    @State var continentSelection = Continent.all

    var filteredAirports: [Airport] {
        airports.filter(by: continentSelection)

        return airports.search(for: searchTerm)
    }

    var body: some View {
        NavigationStack {
            List {
                ForEach(filteredAirports) { airport in
                    NavigationLink(value: airport) {
                        ListLabel(airport: airport)
                    }
                }
                .listRowInsets(EdgeInsets())
                .listRowBackground(Color.clear)
                .padding([.vertical, .trailing], 15)
                .animation(.default, value: searchTerm)
                .animation(.default, value: continentSelection)
            }
            .searchable(text: $searchTerm)
            .autocorrectionDisabled()
            .toolbar {
                ToolBarItems(continentSelection: $continentSelection, filteredAirports: filteredAirports)
            }
            .navigationDestination(for: Airport.self) { airport in
                AirportView(airport: airport)
            }
        }
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
        }
    }
}
