import SwiftUI

struct MedleysView: View {
    // Make the array mutable with @State
    @State private var medleys: [Medley] = Medley.sampleData
    
    var body: some View {
        NavigationStack {
            List(medleys) { medley in
                NavigationLink(destination: MedleyDetail(medley: medley)) {
                    MedleyRow(medley: medley)
                }
                .swipeActions {
                    Button(role: .destructive) {
                        if let index = medleys.firstIndex(where: { $0.id == medley.id }) {
                            medleys.remove(at: index)
                        }
                    } label: {
                        Label("Delete", systemImage: "trash")
                    }
                }
            }
            .navigationTitle("Medleys")
            .toolbar {
                NavigationLink(destination: AddMedleyView(medleys: $medleys)) {
                       Image(systemName: "plus")
                   }
                   .accessibilityLabel("New medley")
               }
        }
    }
}

// The preview part remains unchanged
#Preview {
    MedleysView()
}
