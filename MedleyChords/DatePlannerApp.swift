//
//  MedleyChordsApp.swift
//  MedleyChords
//
//  Created by Timo Engelvaart on 06/10/2023.
//

import SwiftUI

@main
struct DatePlannerApp: App {
    @StateObject private var eventData = EventData()

    var body: some Scene {
        WindowGroup {
            NavigationView {
                EventList()
                Text("Select an Event")
                    .foregroundStyle(.secondary)
            }
            .environmentObject(eventData)

        }
    }
}
