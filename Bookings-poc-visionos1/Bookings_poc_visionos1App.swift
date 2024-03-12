import MapKit
import SwiftUI

@main
struct Bookings_poc_visionos1App: App {
    var body: some Scene {
        WindowGroup(id: SceneType.mainWindow.rawValue) {
            AirportsView()
        }
    }
}
