import MapKit
import SwiftUI

@main
struct Bookings_poc_visionos1App: App {
    @State var viewModel = AirportsView.ViewModel()

    var body: some Scene {
        WindowGroup(id: SceneType.mainWindow.rawValue) {
            AirportsView(viewModel: $viewModel)
        }
    }
}
