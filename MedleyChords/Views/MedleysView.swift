import SwiftUI

struct MedleysView: View {
    //medleys is your reference to the Medley Model
    //So you're basically saying that medleys is an array of Medleymodels
    let medleys: [Medley]
    
    var body: some View {
        NavigationStack {
            List(medleys) { medley in
                NavigationLink(destination: MedleyDetail(medley: medley)) {
                    MedleyRow(medley: medley)
                }
            }
            .navigationTitle("Medleys")
            .toolbar {
                Button(action: {}) {
                    Image(systemName: "plus")
                }
                .accessibilityLabel("New medley")
            }
        }
    }
}

#Preview {
    //Needs a Medley array to compile, look at the Medley array declaration above.
    MedleysView(medleys: Medley.sampleData)
}
