//
//  MedleyChordsApp.swift
//  MedleyChords
//
//  Created by Timo Engelvaart on 06/10/2023.
//

import SwiftUI

@main
struct MedleyChordsApp: App {
    @StateObject private var medleyData = MedleyData()

    var body: some Scene {
        WindowGroup {
            NavigationView {
                MedleyList()
                Text("Select a medley")
                    .foregroundStyle(.secondary)
            }
            .environmentObject(medleyData)
        }
    }
}
