import MapKit
import SwiftUI

@main
struct Bookings_poc_visionos1App: App {
    @State var viewModel = AirportsView.ViewModel()

    var body: some Scene {
        WindowGroup(id: SceneType.mainWindow.rawValue) {
            AirportsView(viewModel: $viewModel)
        }

        WindowGroup("Aiport Details in New Window", for: Airport.ID.self) { $airportId in
            AirportDetailsWindow(viewModel: viewModel, airportId: $airportId)
        }
        .commandsRemoved()
    }
}
