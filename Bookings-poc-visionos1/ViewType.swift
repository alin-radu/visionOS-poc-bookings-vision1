//
//  ViewTypes.swift
//  Bookings-poc-visionos1
//
//  Created by Alin RADU on 17.02.2024.
//

import Foundation

enum ViewType: String, Identifiable {
    case mainWindow
    case mapWindow

    var id: Self {
        self
    }
}
