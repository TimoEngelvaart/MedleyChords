//
//  ContentView.swift
//  MedleyChords
//
//  Created by Timo Engelvaart on 21/10/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        MedleysView(medleys: Medley.sampleData)
    }
}

#Preview {
    ContentView()
}
